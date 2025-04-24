# config/routes.rb
Rails.application.routes.draw do
  # Set root path to tasks index (Issue #6)
  root "tasks#index"

  # Define RESTful routes for tasks
  resources :tasks do
    # Add custom member route for toggling completion status
    patch :toggle_complete, on: :member
  end
end