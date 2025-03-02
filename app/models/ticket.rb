class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings

  validates :ticket_type, presence: true
  validates :name, presence: true # e.g., "General Admission", "VIP"
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :availability, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end