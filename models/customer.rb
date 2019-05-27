require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM users"
    values = []
    users = SqlRunner.run(sql, values)
    result = users.map { |user| User.new( user ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    WHERE customer_id = $1
    ORDER BY title"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = films.map{|film| Film.new(film)}
    return result
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
