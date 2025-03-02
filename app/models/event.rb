class Event < ApplicationRecord
  belongs_to :event_organizer
  has_many :tickets, dependent: :destroy
  has_many :bookings, dependent: :destroy # Consider dependent destroy
  validates :name, presence: true
  validates :date, presence: true
  validates :venue, presence: true
end