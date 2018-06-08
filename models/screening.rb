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




end
