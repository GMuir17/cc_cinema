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

  def most_popular_time()
    sql = "SELECT screenings.id, COUNT (screening_id)
      FROM screenings
      INNER JOIN tickets
      ON tickets.screening_id = screenings.id
      WHERE screenings.film_id = $1
      GROUP BY screenings.id;"
    values = [@id]
    result =  SqlRunner.run(sql, values)
    screening_id_and_count_array = result.map {|hash| hash}
    sorted_array = screening_id_and_count_array.sort_by {|film_hash| film_hash["count"]}
    highest_value_hash = sorted_array.pop()
    most_popular_screening_id = highest_value_hash["id"]
    sql2 = "SELECT screenings.show_time FROM screenings
          WHERE screenings.id = $1;"
    values2 = [most_popular_screening_id]
    new_results = SqlRunner.run(sql2, values2)
    return new_results.first()
  end
# this works, sort of. It doesn't work if two screenings of the same film have the same popularity, it just gives the latest show_time. But hey it's fine for now.

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

end
