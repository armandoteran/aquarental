class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :equipments
  has_many :bookings
  has_many :reservations, through: :equipments, source: :bookings
  has_many :reviews, through: :bookings
end
