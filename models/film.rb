require_relative("../db/sql_runner.rb")

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

end
