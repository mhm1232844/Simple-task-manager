# spec/requests/tasks_spec.rb
# ... (describe GET /tasks) ...
# spec/requests/tasks_spec.rb
require 'rails_helper' # <--- ADD THIS LINE

RSpec.describe "Tasks", type: :request do
  # ... rest of your tests (describe blocks for GET /tasks, GET /tasks/new, POST /tasks, etc.) ...
end
  describe "GET /tasks/new" do
    it "returns http success and renders the new template" do
      get new_task_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      # Check that a new, unsaved Task object is assigned
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "POST /tasks" do
    context "with valid parameters" do
      # Use FactoryBot's attributes_for to get a hash of valid attributes
      let(:valid_attributes) { attributes_for(:task, title: "Valid Task Title") }

      it "creates a new Task" do
        # Expect the Task count to increase by 1 when the POST request is made
        expect {
          post tasks_path, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks list with a notice" do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
        # Check for the flash notice
        expect(flash[:notice]).to eq("Task was successfully created.")
      end
    end

# spec/requests/tasks_spec.rb
# ... (describe POST /tasks) ...

  describe "PATCH /tasks/:id/toggle_complete" do
    let(:task) { create(:task, completed: false) } # Start with an incomplete task

    it "updates the task's completed status from false to true" do
      patch toggle_complete_task_path(task)
      task.reload
      expect(task.completed).to be true
    end

     it "updates the task's completed status from true to false" do
      task.update!(completed: true)
      patch toggle_complete_task_path(task)
      task.reload
      expect(task.completed).to be false
    end

    it "redirects to the tasks list with a notice" do
      patch toggle_complete_task_path(task)
      expect(response).to redirect_to(tasks_path)
      expect(flash[:notice]).to eq("Task status updated.")
    end

      it "handles non-existent tasks gracefully by redirecting" do # Updated description slightly
      patch toggle_complete_task_path(id: task.id + 999) # Non-existent ID

      # Expect a redirect to the tasks index page
      expect(response).to redirect_to(tasks_path)

      # Optionally, also check for the flash alert message
      expect(flash[:alert]).to eq("Task not found.")
    end
  end
# ... (other describes) ...







    context "with invalid parameters" do
      # Use attributes_for but override title to be invalid (nil)
      let(:invalid_attributes) { attributes_for(:task, title: nil) }

      it "does not create a new Task" do
        # Expect the Task count to remain unchanged
        expect {
          post tasks_path, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "re-renders the 'new' template with unprocessable_entity status" do
        post tasks_path, params: { task: invalid_attributes }
        # Should render the 'new' template again, not redirect
        expect(response).to render_template(:new)
        # Should return a 422 Unprocessable Entity status code
        expect(response).to have_http_status(:unprocessable_entity)
        # Check that the @task instance variable contains errors
        expect(assigns(:task).errors).not_to be_empty
      end
    end
  end
# ... (other describes) ...