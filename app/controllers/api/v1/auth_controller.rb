module Api
    module V1
      class AuthController < ApplicationController
        def event_organizer_login
          organizer = EventOrganizer.find_by(email: params[:email])
  
          if organizer&.authenticate(params[:password])
            token = JWT.encode({ organizer_id: organizer.id }, Rails.application.secrets.secret_key_base)
            render json: { token: token, event_organizer: organizer }, status: :ok
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end
  
        def customer_login
          customer = Customer.find_by(email: params[:email])
  
          if customer&.authenticate(params[:password])
            token = JWT.encode({ customer_id: customer.id }, Rails.application.secrets.secret_key_base)
            render json: { token: token, customer: customer }, status: :ok
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
        end
      end
    end
  end
  