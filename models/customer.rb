require_relative("../db/sql_runner.rb")
require_relative("./film.rb")
require_relative("./ticket.rb")

class Customer

  attr_reader(:id)
  attr_accessor(:name, :funds)

# instance methods
  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @name = options["name"]
    @funds = options["funds"].to_i()
  end

  def save()
    sql = "INSERT INTO customers (name, funds)
      VALUES ($1, $2)
      RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first()
    @id = customer["id"].to_i()
  end

  def delete()
    sql = "DELETE FROM customers
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, funds)
      = ($1, $2)
      WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    return Film.map_items(films)
  end

  def number_of_tickets_bought()
    sql = "SELECT * FROM tickets
      WHERE tickets.customer_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    tickets_array = Ticket.map_items(results)
    return tickets_array.length()
  end

  def check_funds()
    sql = "SELECT funds FROM customers
      WHERE id = $1;"
    values = [@id]
    funds = SqlRunner.run(sql, values).first()["funds"].to_i()
    return funds
  end

  def decrease_funds(price)
    sql = "UPDATE customers SET funds
      = $1
      WHERE id = $2;"
    new_funds = @funds - price
    values = [new_funds, @id]
    SqlRunner.run(sql, values)
  end

  # def buy_ticket(film)
  #   # decrease the funds of customer by the film's price, and create a new ticket
  #   sql = "INSERT INTO tickets (customer_id, film_id)
  #     VALUES ($1, $2)
  #     RETURNING id;"
  #   values = []
  # end

# class methods
  def self.all()
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run(sql)
    results = Customer.map_items(customers)
    return results
  end

  def self.map_items(customer_data)
    return customer_data.map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

end
