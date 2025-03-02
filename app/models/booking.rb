class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :event
  belongs_to :ticket

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  # Callback to reduce ticket availability after booking
  after_create :reduce_ticket_availability

  private

  def reduce_ticket_availability
    # Use decrement! to avoid race conditions
    ticket.decrement!(:availability, quantity)
  end
end