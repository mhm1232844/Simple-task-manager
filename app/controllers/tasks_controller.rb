# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # Use a before_action later to find a task for show, edit, update, destroy, toggle
  # before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]

  # GET /tasks
  def index
    # Use the scope defined in the model
    @tasks = Task.ordered_by_creation_desc
  end

  # --- Define other actions later ---

  # private
  #   # Common code to find a task by ID
  #   def set_task
  #     @task = Task.find(params[:id])
  #   end

  #   # Strong parameters for security
  #   def task_params
  #     params.require(:task).permit(:title, :description, :due_date, :completed)
  #   end
end