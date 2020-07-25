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
    description: Faker::Lorem.paragraph_by_chars, #Faker::Company.bs, # ['semi-pro', 'ideal for beginners', 'pro'].sample,
    category: category[:name],
    picture_url: "https://source.unsplash.com/1600x900/?#{category[:img_url]}",
    price_day: rand(200..2000),
    # price_hour: 10,
    start_date: Time.current,
    end_date: 30.day.from_now,
    location: Faker::Address.full_address, #'Mar del Plata',
    state: 'PUBLISHED'
  )
end

def booking_seed(user, equipment)
  equipment.state = 'BOOKED'
  equipment.save!
  Booking.create!(
      user_id: user.id,
      equipment_id: equipment.id,
      total_price: equipment.price_day,
      state: 'PENDING',
      start_date: 1.day.from_now,
      end_date: 2.day.from_now
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
# randomuser.me = https://randomuser.me/api/portraits/med/men/50.jpg
url = 'https://randomuser.me/api/?results=10'
#   user_serialized = open(url).read
#   user_json = JSON.parse(user_serialized)

# puts 'creating users'
# users = []
# 10.times do |i|
#   # binding.pry
#   users << User.create!(
#     email: user_json['results'][i]['email'], # Faker::Internet.email,
#     user_name: user_json['results'][i]['login']['username'], # Faker::Name.first_name,
#     password: 'password',
#     img_url: user_json['results'][i]['picture']['medium'] # "https://kitt.lewagon.com/placeholder/users/random"
# )
# end

puts 'creating users'
users = []
10.times do |i|
  # binding.pry
  users << User.create!(
    email: Faker::Internet.email,
    user_name: Faker::Name.first_name,
    password: 'password',
    img_url: "https://randomuser.me/api/portraits/med/men/#{i}.jpg" # "https://kitt.lewagon.com/placeholder/users/random"
)
end



user_owner = User.create!(email: 'jpcastiglioni@gmail.com',
                          password: '123456',
                          user_name: 'jpcastiglioni',
                          img_url: "https://kitt.lewagon.com/placeholder/users/jpcastiglioni")
user_renter = User.create!(email: 'armandoteran@gmail.com',
                           password: '123456',
                           user_name: 'armandoteran',
                           img_url: "https://kitt.lewagon.com/placeholder/users/armandoteran")

#Equipments
puts 'creating equipments'

equipments = []
subsel = []
25.times do
  eq = equipment_seed(users.sample, categories.sample, adjetives.sample)
  equipments << eq
  subsel << eq
end

3.times do
  equipments << equipment_seed(user_owner, categories.sample, adjetives.sample)
end

puts 'equipments created'

#Bookings
puts 'creating bookings'

# Bookings DE  user_owner
booking_seed(user_owner, subsel.sample)
booking_seed(user_owner, subsel.sample)
book_a = booking_seed(user_owner, subsel.sample)
book_b = booking_seed(user_owner, subsel.sample)

now = Time.now
book_a.start_date = Date.new(2020,5,10)
book_a.end_date = Date.new(2020,5,20)
book_a.state = 'BOOKED'
book_a.save!

book_b.state = 'REJECTED'
book_b.save!


# Bookings a user_owner
book_c = booking_seed(user_renter, equipments[-1])
book_d = booking_seed(user_renter, equipments[-2])

book_d.start_date = Date.new(2020,4,10)
book_d.end_date = Date.new(2020,4,20)
book_d.save!



bookings_old = []
15.times do
  usr = users.sample
   # bookings << booking_seed(users.sample, equipments.sample)
  eqps = Equipment.where.not(state: "BOOKED").where.not(owner: usr)
  eq = eqps.sample
  eq.state = 'BOOKED'
  eq.save!
  bookings_old << Booking.create!(
      user_id: usr.id,
      equipment_id: eq.id,
      total_price: eq.price_day,
      state: 'PENDING',
      start_date: Date.new(2020,3,5),
      end_date: Date.new(2020,4,5)
      )
 end

# 2.times do
#   booking_seed(user_owner, equipments.first)
# end

puts 'bookings created'

#Reviews
puts 'creating reviews'

bookings_old.each do |book|
    book.state = 'REVIEWED'
    book.save!
    review = Review.create!(
      rating: rand(0..5),
      booking_id: book.id,
      content: Faker::Restaurant.review # 'excellent board'
    )
end



