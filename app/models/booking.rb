class Booking < ApplicationRecord
  belongs_to :renter, class_name: "User", foreign_key: "user_id"
  belongs_to :equipment
  has_one :owner, through: :equipment
  has_many :reviews

  validates :state, :start_date, :end_date, :total_price, presence: true
  validate :end_date_after_start_date

  before_validation :set_total_price

  def end_date_after_start_date
    errors.add(:end_date, "can't be before start_date") if start_date > end_date
  end

  def set_total_price
    days = self.equipment.end_date - self.equipment.start_date
    self.total_price = self.equipment.price_day * days
  end
end
