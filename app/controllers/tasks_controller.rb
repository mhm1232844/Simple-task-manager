# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # Setup: Define before_action and rescue_from at the top
  # Ensure all actions needing @task are listed in :only
  before_action :set_task, only: [:edit, :update, :destroy, :toggle_complete] # Add :show if you implement it
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # --- Public Controller Actions ---

  # GET /tasks or GET /
  def index
    # Use the scope for ordering if defined in the model
    @tasks = Task.ordered_by_creation_desc
    # Or use: @tasks = Task.all.order(created_at: :desc)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params) # Uses :create specific params

    if @task.save
      redirect_to tasks_url, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id/edit
  def edit
    # @task is set by before_action
    # View is rendered implicitly
  end

  # PATCH/PUT /tasks/:id
  def update
    # @task is set by before_action
    if @task.update(task_params_for_update) # Uses :update specific params
      redirect_to tasks_url, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity # Re-render edit form on failure
    end
  end

  # PATCH /tasks/:id/toggle_complete
  def toggle_complete
    # @task is set by before_action
    if @task.update(completed: !@task.completed)
      redirect_to tasks_url, notice: "Task status updated."
    else
      # This path is less likely for a boolean toggle but good practice
      redirect_to tasks_url, alert: "Could not update task status."
    end
  end

  # DELETE /tasks/:id (Placeholder - Implement according to guide)
  # def destroy
  #   # @task is set by before_action
  #   @task.destroy
  #   redirect_to tasks_url, notice: "Task was successfully destroyed.", status: :see_other
  # end


  # --- Private Helper Methods ---
  private # All methods below this are private

    # Finds the Task based on the :id parameter for actions listed in before_action
    def set_task
      @task = Task.find(params[:id])
    end

    # Strong parameters for the :create action (doesn't permit :completed)
    def task_params
      params.require(:task).permit(:title, :description, :due_date)
    end

    # Strong parameters for the :update action (allows :completed)
    def task_params_for_update
      params.require(:task).permit(:title, :description, :due_date, :completed)
    end

    # Handles ActiveRecord::RecordNotFound errors triggered by set_task
    def record_not_found
      redirect_to tasks_path, alert: "Task not found."
    end

end # <--- This is the ONLY 'end' at this level, closing the class definition.