source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.6'

# Use Rails 6.1.7
gem 'rails', '~> 6.1.7', '>= 6.1.7.10'

# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 1.1'

# Use Puma as the app server
gem 'puma', '~> 5.0'

# Improve boot times through caching
gem 'bootsnap', '>= 1.4.4', require: false

# Authentication and Authorization
gem 'bcrypt', '~> 3.1.7'  # For password hashing
gem 'jwt', '~> 2.5'       # JSON Web Token for authentication
gem 'devise', '~> 4.9'    # Authentication system
gem 'pundit', '~> 2.3'    # Authorization
gem 'rails_admin', '~> 3.1' # Admin Panel (optional)

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS)
gem 'rack-cors', '~> 1.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'sassc-rails'
