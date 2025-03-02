# Event Booking System (Ruby on Rails)

## Setup Instructions

### Prerequisites
- Install Ruby (version 2.7.6 recommended)
- Install Bundler: `gem install bundler`
- Install Rails: `gem install rails -v 6.1.7`
- Install PostgreSQL and ensure it's running

### Installation Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/diablo3775/event_booking_system.git
   cd event-booking-system
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Setup the database:
   ```sh
   rails db:create db:migrate db:seed
   ```
4. Start the Rails server:
   ```sh
   rails s
   ```
5. The API will be available at `http://localhost:3000`

## API Endpoints

### Authentication (Devise-based)
- Users can sign up and log in.

### Events Management
- `POST /events` (Organizer only) - Create an event
- `GET /events` - List all events
- `PUT /events/:id` (Organizer only) - Update an event
- `DELETE /events/:id` (Organizer only) - Delete an event

### Ticket Booking
- `POST /bookings` (Customer only) - Create a booking

## Code Structure

- `app/models/` - Contains models for Users, Events, Tickets, and Bookings.
- `app/controllers/` - API controllers for handling requests.
- `db/migrate/` - Database migrations.
- `config/routes.rb` - Defines API routes.
- `README.md` - This guide.

## Database Configuration

Modify `config/database.yml` to use PostgreSQL:
```yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: 5
  username: your_postgres_username
  password: your_postgres_password
  host: localhost

development:
  <<: *default
  database: event_booking_system_development

test:
  <<: *default
  database: event_booking_system_test

production:
  <<: *default
  database: event_booking_system_production
  username: event_booking
  password: <%= ENV['EVENT_BOOKING_DATABASE_PASSWORD'] %>
```

## Testing
Run the test suite using RSpec:
```sh
rspec
```

## Contributing
Feel free to submit pull requests or open issues!

---

# Gemfile
source 'https://rubygems.org'

gem 'rails', '~> 6.1.7'
gem 'pg'
gem 'devise'
gem 'pundit'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

# Initialize Rails App
# Run: rails new event_booking_system --api -d postgresql

# Database Migrations
class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false
      t.string :role, null: false, default: "customer"
      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :date
      t.string :venue
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.string :ticket_type
      t.decimal :price
      t.integer :availability
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end

class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :ticket, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end

# Models
class User < ApplicationRecord
  enum role: { customer: 'customer', organizer: 'organizer' }
  has_many :events, foreign_key: :user_id, dependent: :destroy
  has_many :bookings
end

class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :destroy
end

class Ticket < ApplicationRecord
  belongs_to :event
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :ticket
end

# Authentication (Devise setup required)
class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  include Pundit
end

# API Controllers
class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_organizer, only: [:create, :update, :destroy]

  def create
    event = current_user.events.create!(event_params)
    render json: event, status: :created
  end

  def index
    render json: Event.all
  end

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    render json: event
  end

  private
  def event_params
    params.require(:event).permit(:title, :date, :venue)
  end
  
def authorize_organizer
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.organizer?
  end
end

class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_customer, only: [:create]

  def create
    booking = current_user.bookings.create!(booking_params)
    render json: booking, status: :created
  end

  private
  def booking_params
    params.require(:booking).permit(:ticket_id, :quantity)
  end

  def authorize_customer
    render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user.customer?
  end
end
