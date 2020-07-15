# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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
users = []
5.times do
  users << User.create!(
    email: Faker::Internet.email,
    password: 'password'
)
end

#Equipments
puts 'creating equipments'

categories = ['boats', 'kayak', 'stand-up paddle board', 'aquacycle', 'surf table', 'kite surf', 'canoe']

equipments = []
5.times do
  category = categories.sample
  equipments << Equipment.create!(
    user_id: users.sample.id,
    name: ['equipment1', 'equipment2', 'equipment3', 'equipment4', 'equipment5'].sample,
    description: ['semi-pro', 'ideal for beginners', 'pro'].sample,
    category: category,
    picture_url: "https://source.unsplash.com/1600x900/?#{category}",
    price_day: 240,
    price_hour: 10,
    start_date: Time.current,
    end_date: 30.day.from_now,
    location: 'Mar del Plata',
    state: 'published'
)
end

puts 'equipments created'

#Bookings
puts 'creating bookings'
bookings = []
5.times do
  bookings << Booking.create!(
    user_id: users.sample.id,
    equipment_id: equipments.sample.id,
    total_price: 480,
    state: 'pending',
    start_date: 1.day.from_now,
    end_date: 2.day.from_now,
)
end
puts 'bookings created'

#Reviews
puts 'creating reviews'
5.times do
  review = Review.create!(
    rating: 4,
    booking_id: bookings.sample.id,
    content: 'excellent board'
)
end
