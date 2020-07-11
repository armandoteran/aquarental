class Booking < ApplicationRecord
  belongs_to :renter, class_name: "User", foreign_key: "user_id"
  belongs_to :equipment
  has_one :owner, through: :equipment
end
