require_relative("../models/customer.rb")
require_relative("../models/film.rb")
require_relative("../models/ticket.rb")

require("pry-byebug")

# customers
customer1 = Customer.new({
  "name" => "Julius",
  "funds" => 200
  })

customer2 = Customer.new({
  "name" => "Pompey",
  "funds" => 100
  })

customer3 = Customer.new({
  "name" => "Crassus",
  "funds" => 10_000
  })

# films
film1 = Film.new({
  "title" => "Spartacus",
  "price" => 50
  })

film2 = Film.new({
  "title" => "Cleopatra",
  "price" => 80
  })

film3 = Film.new({
  "title" => "Gladiator",
  "price" => 100
  })

# tickets
ticket1 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film1.id()
  })

ticket2 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film2.id()
  })

ticket3 = Ticket.new({
  "customer_id" => customer3.id(),
  "film_id" => film3.id()
  })

ticket4 = Ticket.new({
   "customer_id" => customer2.id(),
  "film_id" => film3.id()
  })
