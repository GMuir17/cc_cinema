require_relative("../models/customer.rb")
require_relative("../models/film.rb")
require_relative("../models/ticket.rb")
require_relative("../models/screening.rb")

require("pry-byebug")

Ticket.delete_all()
Screening.delete_all()
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

# screenings
screening1 = Screening.new({
  "show_time" => "17:00",
  "film_id" => film1.id(),
  "max_customers" => 2
  })
screening1.save()

screening2 = Screening.new({
  "show_time" => "18:00",
  "film_id" => film2.id(),
  "max_customers" => 2
  })
screening2.save()

screening3 = Screening.new({
  "show_time" => "19:00",
  "film_id" => film3.id(),
  "max_customers" => 2
  })
screening3.save()

screening4 = Screening.new({
  "show_time" => "20:00",
  "film_id" => film1.id(),
  "max_customers" => 2
  })
screening4.save()

screening5 = Screening.new({
  "show_time" => "00:00",
  "film_id" => film2.id(),
  "max_customers" => 2
  })
screening5.save()

# tickets
ticket1 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film1.id(),
  "screening_id" => screening1.id()
  })
ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film2.id(),
  "screening_id" => screening4.id()
  })
ticket2.save()

ticket3 = Ticket.new({
  "customer_id" => customer3.id(),
  "film_id" => film3.id(),
  "screening_id" => screening3.id()
  })
ticket3.save()

ticket4 = Ticket.new({
   "customer_id" => customer2.id(),
  "film_id" => film3.id(),
  "screening_id" => screening3.id()
  })
ticket4.save()

ticket5 = Ticket.new({
  "customer_id" => customer3.id(),
  "film_id" => film2.id(),
  "screening_id" => screening2.id()
  })
ticket5.save()

ticket6 = Ticket.new({
  "customer_id" => customer1.id(),
  "film_id" => film2.id(),
  "screening_id" => screening5.id()
  })
ticket6.save()

ticket7 = Ticket.new({
  "customer_id" => customer3.id(),
  "film_id" => film2.id(),
  "screening_id" => screening5.id()
  })
ticket7.save()

binding.pry
nil
