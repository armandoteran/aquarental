class Review < ApplicationRecord
  belongs_to :booking
  # belongs_to :user, through: :bookings

  validates :rating, presence: true

  # def self.ususario
  #   self.booking.renter
  # end

  def user
    booking.renter
  end
end
