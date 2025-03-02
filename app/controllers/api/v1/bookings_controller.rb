class Api::V1::BookingsController < ApplicationController
  before_action :authenticate_customer

def create
    puts params[:booking][:ticket_id] #This to check the ticket ID or do what you please with params
    ticket = Ticket.find(params[:booking][:ticket_id])

    # Check if enough tickets are available
    if ticket.availability < params[:quantity].to_i
      return render json: { error: "Not enough tickets available" }, status: :unprocessable_entity
    end

    # Create the booking
    booking = current_customer.bookings.new(booking_params)

    if booking.save
      # Reduce ticket availability
      ticket.update(availability: ticket.availability - params[:quantity].to_i)

      render json: booking, status: :created
    else
      render json: { error: booking.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:event_id, :ticket_id, :quantity)
  end
end