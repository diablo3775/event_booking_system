class Api::V1::TicketsController < ApplicationController
  before_action :authenticate_organizer, only: [:create, :index]  #Protect index route too

  def index
    @tickets = Ticket.all
    render json: @tickets
  end

  def create
    ticket = Event.find(ticket_params[:event_id]).tickets.new(ticket_params)
    if ticket.save
      render json: ticket, status: :created
    else
      render json: { error: ticket.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:event_id, :name, :price, :availability)
  end
end