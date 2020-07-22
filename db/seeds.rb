# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'time'

categories = [ {name: 'Bote', img_url: 'bote'},
               {name: 'Kayak', img_url: 'kayak'},
               {name: 'Paddle board', img_url: 'paddleboard'},
               {name: 'Tablas de surf', img_url: 'surfing table'},
               {name: 'Kite surf', img_url: 'kite surf'},
               {name: 'Wind surf', img_url: 'windsurf'},
               {name: 'Canoas', img_url: 'canoe'}]

adjetives = ['El mejor',
             'Imperdible',
             'Inmejorable',
             'Oferton:',
             'Carito, pero lo vale:',
             'Para toda la familia:',
             'Totalmente equipado!,']

def equipment_seed(user, category, adjetive)
  Equipment.create!(
    user_id: user.id,
    name: "#{adjetive} #{category[:name]}",
    description: Faker::Company.bs, # ['semi-pro', 'ideal for beginners', 'pro'].sample,
    category: category[:name],
    picture_url: "https://source.unsplash.com/1600x900/?#{category[:img_url]}",
    price_day: rand(200..2000),
    # price_hour: 10,
    start_date: Time.current,
    end_date: 30.day.from_now,
    location: Faker::Address.full_address, #'Mar del Plata',
    state: 'published'
  )
end

def booking_seed(user, equipment)
  Booking.create!(
      user_id: user.id,
      equipment_id: equipment.id,
      total_price: equipment.price_day,
      state: 'pending',
      start_date: 1.day.from_now,
      end_date: 2.day.from_now,
  )
end

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

user_owner = User.create!(email: 'jpcastiglioni@gmail.com', password: '123456')
user_renter = User.create!(email: 'armandoteran@gmail.com', password: '123456')

#Equipments
puts 'creating equipments'

equipments = []
15.times do
  equipments << equipment_seed(users.sample, categories.sample, adjetives.sample)
end

2.times do
  equipments << equipment_seed(user_owner, categories.sample, adjetives.sample)
end

puts 'equipments created'

#Bookings
puts 'creating bookings'
bookings = []
5.times do
  bookings << booking_seed(users.sample, equipments.sample)
end

booking_seed(user_renter, equipments[-1])
booking_seed(user_renter, equipments[-2])
2.times do
  booking_seed(user_owner, equipments.sample)
end

puts 'bookings created'

#Reviews
puts 'creating reviews'
5.times do
  review = Review.create!(
    rating: rand(0..5),
    booking_id: bookings.sample.id,
    content: Faker::Restaurant.review # 'excellent board'
)
end



