require_relative("../models/customer.rb")
require_relative("../models/film.rb")
require_relative("../models/ticket.rb")

require("pry-byebug")

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

# customers
customer1 = Customer.new({
  "name" => "Julius",
  "funds" => 200
  })
customer1.save()

customer2 = Customer.new({
  "name" => "Pompey",
  "funds" => 100
  })
customer2.save()

customer3 = Customer.new({
  "name" => "Crassus",
  "funds" => 10_000
  })
customer3.save()

# films
film1 = Film.new({
  "title" => "Spartacus",
  "price" => 50
  })
film1.save()

film2 = Film.new({
  "title" => "Cleopatra",
  "price" => 80
  })
film2.save()

film3 = Film.new({
  "title" => "Gladiator",
  "price" => 100
  })
film3.save()

# tickets
ticket1 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film1.id()
  })
ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film2.id()
  })
ticket2.save()

ticket3 = Ticket.new({
  "customer_id" => customer3.id(),
  "film_id" => film3.id()
  })
ticket3.save()

ticket4 = Ticket.new({
   "customer_id" => customer2.id(),
  "film_id" => film3.id()
  })
ticket4.save()

binding.pry
nil
