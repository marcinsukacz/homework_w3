require_relative('./models/customer')
require_relative('./models/film')
require_relative('./models/ticket')

require('pry')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Marcin Sukacz' })
customer1.save()
customer2 = Customer.new({ 'name' => 'Luke Walton' })
customer2.save()

customer2.name = 'Jim Giles'
customer2.update()

film1 = Film.new({ 'title' => 'Rocky', 'price' => 8})
film1.save()
film2 = Film.new({ 'title' => 'E.T.', 'price' => 6})
film2.save()


ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save()





binding.pry
nil
