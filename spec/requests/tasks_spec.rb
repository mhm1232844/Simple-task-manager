# spec/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe "Tasks", type: :request do

  # --- GET /tasks ---
  describe "GET /tasks" do
    it "returns http success and renders the index template" do
      get tasks_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it "assigns all tasks to @tasks ordered by creation descending" do
      task2 = create(:task, title: "Second Task", created_at: 1.day.ago)
      task1 = create(:task, title: "First Task", created_at: 2.days.ago)
      task3 = create(:task, title: "Third Task", created_at: Time.current)

      get tasks_path
      expect(assigns(:tasks)).to eq([task3, task2, task1])
      expect(response.body).to include("First Task")
      expect(response.body).to include("Second Task")
      expect(response.body).to include("Third Task")
    end

    context "when no tasks exist" do
      it "renders the index template and shows a message" do
        get tasks_path
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(assigns(:tasks)).to be_empty
        expect(response.body).to include("No tasks yet!")
      end
    end
  end # <<<< END for GET /tasks

  # --- GET /tasks/new ---
  describe "GET /tasks/new" do
    it "returns http success and renders the new template" do
      get new_task_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
      expect(assigns(:task)).to be_a_new(Task)
    end
  end # <<<< END for GET /tasks/new

  # --- POST /tasks ---
  describe "POST /tasks" do
    context "with valid parameters" do
      let(:valid_attributes) { attributes_for(:task, title: "Valid Task Title") }

      it "creates a new Task" do
        expect {
          post tasks_path, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks list with a notice" do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
        expect(flash[:notice]).to eq("Task was successfully created.")
      end
    end # <<<< END for context valid create

    context "with invalid parameters" do
      let(:invalid_attributes) { attributes_for(:task, title: nil) }

      it "does not create a new Task" do
        expect {
          post tasks_path, params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "re-renders the 'new' template with unprocessable_entity status" do
        post tasks_path, params: { task: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(assigns(:task).errors).not_to be_empty
      end
    end # <<<< END for context invalid create
  end # <<<< END for POST /tasks

  # --- PATCH /tasks/:id/toggle_complete ---
  describe "PATCH /tasks/:id/toggle_complete" do
    let(:task) { create(:task, completed: false) }

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

    # Uses the corrected expectation for redirection on not found
    it "handles non-existent tasks gracefully by redirecting" do
      patch toggle_complete_task_path(id: task.id + 999) # Non-existent ID
      expect(response).to redirect_to(tasks_path)
      expect(flash[:alert]).to eq("Task not found.")
    end
  end # <<<< END for PATCH /toggle_complete

  # --- GET /tasks/:id/edit ---
  describe "GET /tasks/:id/edit" do
    let(:task) { create(:task) }

    it "returns http success and renders the edit template" do
      get edit_task_path(task)
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
      expect(assigns(:task)).to eq(task)
    end

    # Uses the corrected expectation for redirection on not found
    it "handles non-existent tasks gracefully by redirecting" do
      get edit_task_path(id: task.id + 999)
      expect(response).to redirect_to(tasks_path)
      expect(flash[:alert]).to eq("Task not found.")
    end
  end # <<<< END for GET /edit

  # --- PATCH /tasks/:id ---
  describe "PATCH /tasks/:id" do
    let(:task) { create(:task, title: "Old Title", description: "Old Desc", completed: false) }

    context "with valid parameters" do
      let(:new_attributes) { { title: "New Title", description: "New Desc", completed: true } }

      it "updates the requested task" do
        patch task_path(task), params: { task: new_attributes }
        task.reload
        expect(task.title).to eq("New Title")
        expect(task.description).to eq("New Desc")
        expect(task.completed).to be true
      end

      it "redirects to the tasks list with a notice" do
        patch task_path(task), params: { task: new_attributes }
        expect(response).to redirect_to(tasks_path)
        expect(flash[:notice]).to eq("Task was successfully updated.")
      end
    end # <<<< END for context valid update

    context "with invalid parameters" do
      let(:invalid_attributes) { { title: "" } }

      it "does not update the task" do
         original_title = task.title
         patch task_path(task), params: { task: invalid_attributes }
         task.reload
         expect(task.title).to eq(original_title)
      end

      it "re-renders the 'edit' template with unprocessable_entity status" do
        patch task_path(task), params: { task: invalid_attributes }
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(assigns(:task).errors).not_to be_empty
      end
    end # <<<< END for context invalid update

     # Uses the corrected expectation for redirection on not found
     it "handles non-existent tasks gracefully by redirecting" do
      patch task_path(id: task.id + 999), params: { task: { title: "Trying to update" } }
      expect(response).to redirect_to(tasks_path)
      expect(flash[:alert]).to eq("Task not found.")
    end
  end # <<<< END for PATCH /tasks/:id

  # --- Add describe block for DELETE /tasks/:id later when implementing Issue #5 ---
  # describe "DELETE /tasks/:id" do
  #   let!(:task) { create(:task) }
  #
  #   it "destroys the requested task" do
  #     expect {
  #       delete task_path(task)
  #     }.to change(Task, :count).by(-1)
  #   end
  #
  #   it "redirects to the tasks list with a notice" do
  #     delete task_path(task)
  #     expect(response).to redirect_to(tasks_path)
  #     expect(flash[:notice]).to eq("Task was successfully destroyed.")
  #     expect(response).to have_http_status(:see_other) # Check status for Turbo redirects
  #   end
  #
  #   it "handles non-existent tasks gracefully by redirecting" do
  #      delete task_path(id: task.id + 999)
  #      expect(response).to redirect_to(tasks_path)
  #      expect(flash[:alert]).to eq("Task not found.")
  #   end
  # end # <<<< END for DELETE /tasks/:id

end # <<<< FINAL END for RSpec.describe "Tasks"