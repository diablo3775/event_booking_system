class Api::V1::EventsController < ApplicationController
    before_action :authenticate_organizer, only: [:create, :update, :destroy]
  
    def index
      events = Event.all
      render json: events
    end
  
    def create
      event = current_organizer.events.new(event_params)
      if event.save
        render json: event, status: :created
      else
        render json: { error: event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      event = current_organizer.events.find(params[:id])
      if event.update(event_params)
        render json: event
      else
        render json: { error: event.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      event = current_organizer.events.find(params[:id])
      event.destroy
      render json: { message: 'Event deleted' }
    end
  
    private
  
    def event_params
      params.require(:event).permit(:name, :date, :venue)
    end
  end
  