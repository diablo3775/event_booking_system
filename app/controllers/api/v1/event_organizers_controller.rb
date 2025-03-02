class Api::V1::EventOrganizersController < ApplicationController
    def create
      if EventOrganizer.exists?(email: event_organizer_params[:email])
        render json: { error: 'Event organizer with this email already exists' }, status: :unprocessable_entity
      else
        organizer = EventOrganizer.new(event_organizer_params)
        if organizer.save
          render json: { message: 'Event organizer created successfully', organizer: organizer }, status: :created
        else
          render json: { errors: organizer.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  
    private
  
    def event_organizer_params
      params.require(:event_organizer).permit(:name, :email, :password)    end
  end