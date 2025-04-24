# spec/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  describe "GET /tasks (index)" do
    it "returns http success and renders the index template" do
      get tasks_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it "assigns all tasks to @tasks ordered by creation descending" do
      # Create tasks out of order to test sorting
      task2 = create(:task, title: "Second Task", created_at: 1.day.ago)
      task1 = create(:task, title: "First Task", created_at: 2.days.ago)
      task3 = create(:task, title: "Third Task", created_at: Time.current)

      get tasks_path

      # Check that @tasks instance variable is assigned correctly
      expect(assigns(:tasks)).to eq([task3, task2, task1]) # Newest first

      # Check that task titles appear in the response body
      expect(response.body).to include("First Task")
      expect(response.body).to include("Second Task")
      expect(response.body).to include("Third Task")
    end

     it "displays a message when no tasks exist" do
      get tasks_path
      expect(response.body).to include("No tasks yet!") # Check for empty state message
    end
  end

  # --- Add tests for other actions (new, create, etc.) later ---
end
