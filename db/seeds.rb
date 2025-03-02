# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Create Event Organizers
organizer1 = EventOrganizer.create!(name: "Organizer One", email: "organizer1@example.com", password: "password")
organizer2 = EventOrganizer.create!(name: "Organizer Two", email: "organizer2@example.com", password: "password")

# Create Customers
customer1 = Customer.create!(name: "Customer One", email: "customer1@example.com", password: "password")
customer2 = Customer.create!(name: "Customer Two", email: "customer2@example.com", password: "password")

# Create Events
event1 = Event.create!(name: "Awesome Concert", date: Date.tomorrow, venue: "The Arena", event_organizer: organizer1)
event2 = Event.create!(name: "Tech Conference", date: Date.tomorrow + 7, venue: "Convention Center", event_organizer: organizer2)

# Create Tickets for Events (Important for Bookings)
# Create Tickets for Events (Important for Bookings)
ticket1 = Ticket.create!(event: event1, ticket_type: "General Admission", name: "Tier 1", price: 50, availability: 100)
ticket2 = Ticket.create!(event: event1, ticket_type: "VIP", name: "Tier 2", price: 150, availability: 20)
ticket3 = Ticket.create!(event: event2, ticket_type: "Early Bird", name: "Tier 3", price: 30, availability: 50)

puts "Seed data created successfully!"