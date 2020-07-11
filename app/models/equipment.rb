class Equipment < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :bookings, dependent: :destroy

  # validates :name, :description, :user, presence: true
end
