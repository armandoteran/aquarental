class Equipment < ApplicationRecord
  VALID_CATEGORIES = ["Bote", "Kayak", "Paddle board", "Tablas de surf", "Kite surf", "Wind surf", "Canoas"].freeze
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings

  validates :name, :description, :price_day,
            :start_date, :end_date, :location, presence: true

  validates :category, inclusion: { in: VALID_CATEGORIES }

  validate :end_date_after_start_date

  before_save :fill_image_url

  def end_date_after_start_date
    errors.add(:end_date, "can't be before start_date") if start_date > end_date
  end

  include PgSearch::Model
  pg_search_scope :search_by,
    against: [:name, :description, :category, :location],
    using: {
      tsearch: { prefix: true }
    }

  def avg_rating
    return 0 if reviews.empty?

    reviews.inject(0){ |sum, review| sum + review.rating } / reviews.count
  end

  private

  def fill_image_url
    self.picture_url ||= "https://source.unsplash.com/1600x900/?#{category.downcase}"
  end
end

# STATES:
# => UNPUBLISHED
# => PUBLISHED
