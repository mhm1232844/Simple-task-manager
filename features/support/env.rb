# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.


require 'cucumber/rails'

# --- DatabaseCleaner Configuration ---

# Require the necessary gems
require 'database_cleaner/active_record' # Change line 13 to this
require 'database_cleaner/cucumber' # Often needed for the Cucumber hooks
# If using ActiveRecord:
require 'database_cleaner/active_record'


# Configure DatabaseCleaner strategies
# Recommended strategy for Cucumber features is truncation, especially with JS
DatabaseCleaner.strategy = :truncation

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. The comments below from the original file might be helpful.
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('not @no-txn', 'not @selenium', 'not @culerity', 'not @celerity', 'not @javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end


# Run database cleaning around each scenario
Around do |scenario, block|
  DatabaseCleaner.cleaning(&block)
end

# --- End DatabaseCleaner Configuration ---


# By default, any exception happening in your Rails application will bubble up
# to Cucumber so that your scenario will fail. This is a different from how
# your application behaves in the production environment, where an error page will
# be rendered instead.
#
# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page (just like when the app is running in production).
# Typical scenarios where you want to do this is when you test your error pages.
# There are two ways to allow Rails to rescue exceptions:
#
# 1) Tag your scenario (or feature) with @allow-rescue
#
# 2) Set the value below to true. Beware that doing this globally is not
# recommended as it will mask a lot of errors for you!
#
ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# (This section about database is now handled by the DatabaseCleaner config above)
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
# The following block was the second DatabaseCleaner block - make sure it's removed.
# begin
#   DatabaseCleaner.strategy = :transaction
# rescue NameError
#   raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
# end


# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation