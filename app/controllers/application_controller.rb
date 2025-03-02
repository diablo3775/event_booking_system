class ApplicationController < ActionController::Base  # Changed from ActionController::API
  protect_from_forgery with: :null_session  # Important for APIs to prevent CSRF errors
  def authenticate_organizer
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last

    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })
      @current_organizer = EventOrganizer.find(decoded_token[0]['organizer_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_organizer
    @current_organizer
  end

  helper_method :current_organizer

  def authenticate_customer
    auth_header = request.headers['Authorization']
    token = auth_header&.split(' ')&.last

    begin
      decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' })
      @current_customer = Customer.find(decoded_token[0]['customer_id'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  def current_customer
    @current_customer
  end

  helper_method :current_customer
end