# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # Setup: Define before_action and rescue_from at the top
  before_action :set_task, only: [:edit, :update, :destroy, :toggle_complete]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # --- Public Controller Actions ---

  # GET /tasks or GET /
  def index
    # Use the scope for ordering if defined in the model, otherwise use Task.all
    # Assuming you have Task.ordered_by_creation_desc from previous steps:
    @tasks = Task.ordered_by_creation_desc
    # If not, use: @tasks = Task.all.order(created_at: :desc)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params) # Uses the private task_params method below

    if @task.save
      redirect_to tasks_url, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /tasks/:id/toggle_complete
  def toggle_complete
    # @task is set by before_action
    if @task.update(completed: !@task.completed)
      redirect_to tasks_url, notice: "Task status updated."
    else
      redirect_to tasks_url, alert: "Could not update task status."
    end
  end

  # --- Add other actions (show, edit, update, destroy) here as you implement them ---
  # Example placeholders (implement according to the guide):
  # def edit
  #   # @task is set by before_action
  # end
  #
  # def update
  #   # @task is set by before_action
  #   if @task.update(task_params_for_update) # Needs task_params_for_update method
  #     redirect_to tasks_url, notice: "Task was successfully updated."
  #   else
  #     render :edit, status: :unprocessable_entity
  #   end
  # end
  #
  # def destroy
  #   # @task is set by before_action
  #   @task.destroy
  #   redirect_to tasks_url, notice: "Task was successfully destroyed.", status: :see_other
  # end

  # --- Private Helper Methods ---
  private # All methods below this line are private

    # Finds the Task based on the :id parameter for actions listed in before_action
    def set_task
      @task = Task.find(params[:id])
    end

    # Strong parameters for the :create action (doesn't permit :completed)
    def task_params
      params.require(:task).permit(:title, :description, :due_date)
    end

    # You will likely need a separate params method for update later:
    # def task_params_for_update
    #   params.require(:task).permit(:title, :description, :due_date, :completed)
    # end

    # Handles ActiveRecord::RecordNotFound errors triggered by set_task
    def record_not_found
      redirect_to tasks_path, alert: "Task not found."
    end

end # <--- This is the FINAL end for the Class definition