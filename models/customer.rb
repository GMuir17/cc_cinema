require_relative("../db/sql_runner.rb")

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
