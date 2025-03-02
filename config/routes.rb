# Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     get 'tickets/create'
  #   end
  # end
#   namespace :api do
#     namespace :v1 do
#       # Events
#       resources :events, only: [:create, :update, :destroy]

#       # Tickets
#       resources :tickets, only: [:create]

#       # Bookings (Ticket Purchases)
#       resources :bookings, only: [:create]

#       # Event Organizer Authentication Routes
#       resources :event_organizers, only: [:create]  # Signup
#       post 'event_organizers/login', to: 'auth#event_organizer_login'  # Login for Event Organizers

#       # Customer Authentication Routes
#       resources :customers, only: [:create]  # Signup
#       post 'customers/login', to: 'auth#customer_login'  # Login for Customers
#     end
#   end
# end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Events
      resources :events, only: [:create, :update, :destroy, :index]

      # Tickets
      resources :tickets, only: [:create, :index]  # <-- ADDED index

      # Bookings (Ticket Purchases)
      resources :bookings, only: [:create]

      # Event Organizer Authentication Routes
      resources :event_organizers, only: [:create]  # Signup
      post 'event_organizers/login', to: 'auth#event_organizer_login'  # Login for Event Organizers

      # Customer Authentication Routes
      resources :customers, only: [:create]  # Signup
      post 'customers/login', to: 'auth#customer_login'  # Login for Customers
    end
  end
end