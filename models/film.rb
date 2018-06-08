require_relative("../db/sql_runner.rb")
require_relative("./customer.rb")
require_relative("./ticket.rb")

class Film

  attr_reader(:id)
  attr_accessor(:title, :price)

# instance methods
  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @title = options["title"]
    @price = options["price"].to_i()
  end

  def save()
    sql = "INSERT INTO films (title, price)
      VALUES ($1, $2)
      RETURNING id;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first()
    @id = film["id"].to_i()
  end

  def delete()
    sql = "DELETE FROM films
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, price)
      = ($1, $2)
      WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    return Customer.map_items(customers)
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings
      INNER JOIN tickets
      ON tickets.screening_id = screenings.id
      WHERE screenings.film_id = $1;"
    values = [@id]
    screenings = SqlRunner.run(sql, values)
    return Screening.map_items(screenings)
  end

  def find_price()
    sql = "SELECT price FROM films
      WHERE id = $1;"
    values = [@id]
    price = SqlRunner.run(sql,values).first()["price"].to_i()
    return price
  end

  def number_of_tickets_sold()
    sql = "SELECT * FROM tickets
      WHERE tickets.film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    tickets_array = Ticket.map_items(results)
    return tickets_array.length()
  end

  # class methods
  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run(sql)
    results = Film.map_items(films)
    return results
  end

  def self.map_items(film_data)
    return film_data.map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def self.most_popular_time()
    sql = "SELECT screening_id, COUNT (screening_id)
      FROM tickets
      GROUP BY screening_id;"
    hash_array =  SqlRunner.run(sql)
    return hash_array.map {|count| count}
  end


end
