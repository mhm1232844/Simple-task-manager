# features/support/database_cleaner.rb
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :transaction # Or :truncation

Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

# Optional: If you need seeding before features or scenarios
# BeforeAll do
#   DatabaseCleaner.start
#   # Seed data here if needed globally before all features
# ensure
#   DatabaseCleaner.clean
# end

# Before do |scenario|
#   DatabaseCleaner.start
#   # Seed data here specific to scenarios with certain tags, etc.
# end

# After do |scenario|
#   DatabaseCleaner.clean
# end