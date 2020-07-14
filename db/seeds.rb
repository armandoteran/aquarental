# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "open-uri"
require 'time'

#Destroy review
puts 'deleting reviews'
Review.destroy_all
puts 'reviews database is clean'
# Destroy booking
puts 'deleting bookings'
Booking.destroy_all
puts 'bookings database is clean'
# Destroy equipment
puts 'deleting equipments'
Equipment.destroy_all
puts 'equipments database is clean'
# Destroy user
puts 'deleting users'
User.destroy_all
puts 'users database is clean'

#Users
puts 'creating users'
user1 = User.create!(
  email: 'john.smith@gmail.com',
  password: 'password'
)

#Equipments
puts 'creating equipments'
longboard1 = Equipment.create!(
  user_id: user1.id,
  name: 'longboard',
  description: 'Length: 8ft 6in, 9ft 1in, 9ft 6in. Construction: polyurethane, 0.25in cedar stringer. Profile: medium rocker. Nose: round. Thickness: [9ft 1in] 2.8in, [9ft 6in] 3.1in',
  category: 'non motorized',
  price_day: 240,
  price_hour: 10,
  start_date: Time.current,
  end_date: 30.day.from_now,
  location: 'Mar del Plata',
  state: 'published'
)

file = URI.open('https://images.unsplash.com/photo-1560616275-5ca158bd4876?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1051&q=80')
longboard1.photo.attach(
  io: file, filename: 'longboard.jpeg', content_type: 'image/jpeg'
)
puts 'equipments created'

#Bookings
puts 'creating bookings'
booking1 = Booking.create!(
  total_price: 480,
  state: 'pending',
  start_date: 1.day.from_now,
  end_date: 2.day.from_now,
  user_id: user1.id,
  equipment_id: longboard1.id
  )
puts 'bookings created'

#Reviews
puts 'creating reviews'
review1 = Review.create!(
  rating: 4,
  booking_id: booking1.id,
  content: 'excellent board'
  )
