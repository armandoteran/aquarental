class Equipment < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :bookings, dependent: :destroy

  validates :name, :description, :category, :price_day,
            :start_date, :end_date, :location, presence: true

  validate :end_date_after_start_date

  def end_date_after_start_date
    errors.add(:end_date, "can't be before start_date") if start_date > end_date
  end

  include PgSearch::Model
  pg_search_scope :search_by,
    against: [:name, :description, :category, :location],
    using: {
      tsearch: { prefix: true }
    }
end

# STATES:
# => UNPUBLISHED
# => PUBLISHED
