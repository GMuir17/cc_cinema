require_relative("../db/sql_runner.rb")
require_relative("./film.rb")

class Screening

  attr_reader(:id)
  attr_accessor(:show_time, :film_id)

# instance methods
  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @show_time = options["show_time"]
    @film_id = options["film_id"].to_i()
  end

  def save()
    sql = "INSERT INTO screenings (show_time, film_id)
      VALUES ($1, $2)
      RETURNING id;"
    values = [@show_time, @film_id]
    screening = SqlRunner.run(sql, values).first()
    @id = screening["id"].to_i()
  end

  def delete()
    sql = "DELETE FROM screenings
      WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# class methods
  def self.all()
    sql = "SELECT * FROM screenings;"
    screenings = SqlRunner.run(sql)
    results = Screening.map_items(screenings)
    return results
  end

  def self.map_items(screening_data)
    screening_data.map {|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
