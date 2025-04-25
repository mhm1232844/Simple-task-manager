# Gemfile
source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.2", ">= 7.2.2.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# --- Database Configuration ---
# Use sqlite3 as the database for Active Record in development and test
# Make sure the version matches your setup needs, >= 1.4 is common
gem "sqlite3", ">= 1.4"

# Use PostgreSQL in production
group :production do
  gem 'pg', '~> 1.1' # Or appropriate version for your Heroku/production setup
  # gem 'rails_12factor' # Consider if needed for Heroku logging/statics
end
# --- End Database Configuration ---


# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Required for COM automation on Windows (e.g., with win32ole examples)
gem "win32ole", platforms: :windows

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
gem 'fiddle'
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"


# --- Development and Test Environment Gems ---
# Gems used in both development and test environments
group :development, :test do
  # Debugger gem
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Core RSpec testing framework for Rails
  # Needed in dev for generators, test for running specs
  gem 'rspec-rails', '~> 6.0' # Or latest appropriate version

  # Provides matchers like render_template, assigns (needed due to RSpec error)
  gem 'rails-controller-testing' # <--- ADDED THIS LINE

  # FactoryBot for creating test data objects
  gem 'factory_bot_rails'

  # Faker for generating realistic fake data (names, addresses, etc.)
  gem 'faker'

  # Concise RSpec matchers for common Rails tests (validations, associations)
  gem 'shoulda-matchers', '~> 5.0'

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  # Run manually via `brakeman`
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  # Run manually via `rubocop`
  gem "rubocop-rails-omakase", require: false
end

# --- Test Environment Only Gems ---
# Gems ONLY needed when running tests
group :test do
  # Cucumber for Behavior-Driven Development (BDD)
  gem 'cucumber-rails', require: false

  # Cleans the test database between test runs
  gem 'database_cleaner-active_record'
  # Note: database_cleaner-cucumber is usually not needed if database_cleaner-active_record is configured correctly in env.rb

  # Core library for acceptance testing (simulates user interaction)
  gem 'capybara'

  # Default browser driver for Capybara (can run headless)
  gem 'selenium-webdriver'

  # If using PG in test environment INSTEAD of Sqlite:
  # gem 'pg', '~> 1.1'
end



# Gems ONLY needed during development
group :development do
  # Interactive console in browser on error pages
  # See https://github.com/rails/web-console
  gem "web-console"

  # Better highlighting for error locations
  # See https://github.com/ruby/error_highlight
  gem "error_highlight", ">= 0.4.0", platforms: [ :ruby ]

  # If using PG in development environment INSTEAD of Sqlite:
  # gem 'pg', '~> 1.1'
end
