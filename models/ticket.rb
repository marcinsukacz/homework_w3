require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map {|ticket| Ticket.new(ticket)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end



# Create a system that handles bookings for our newly built cinema! We want you to be able to check that all the methods you write can work in Pry - please do not spend time creating a Runner file or User Interface.
#
# Your app should have:
# Customers
#
# name
# funds
# Films
#
# title
# price
# Tickets
#
# customer_id
# film_id
# Your app should be able to:
# Create customers, films and tickets
# CRUD actions (create, read, update, delete) customers, films and tickets.
# Show which films a customer has booked to see, and see which customers are coming to see one film. At least one of these should return the data ordered by a property (customers or films ordered by name/title, for instance).
# Basic extensions:
# Buying tickets should decrease the funds of the customer by the price
# Check how many tickets were bought by a customer
# Check how many customers are going to watch a certain film
# Advanced extensions:
# Create a screenings table that lets us know what time films are showing
# Write a method that finds out what is the most popular time (most tickets sold) for a given film
# Limit the available tickets for screenings.
# Add any other extensions you think would be great to have at a cinema!
