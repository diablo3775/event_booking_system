class EventOrganizer < ApplicationRecord
  has_secure_password
  has_many :events
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end