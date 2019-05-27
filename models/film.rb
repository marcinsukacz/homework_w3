require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
    (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = films.map {|film| Film.new(films)}
    return result
  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE film_id = $1
    ORDER BY name"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = customers.map{|customer| Customer.new(customer)}
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
