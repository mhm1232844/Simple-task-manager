# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
  # Setup: Define before_action and rescue_from at the top
  before_action :set_task, only: [:edit, :update, :destroy, :toggle_complete]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # --- Public Controller Actions ---

  # GET /tasks or GET /
  def index
    @tasks = Task.ordered_by_creation_desc
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_url, notice: "Task was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /tasks/:id/edit
  def edit
    # @task is set by before_action
  end

  # PATCH/PUT /tasks/:id
  def update
    # @task is set by before_action
    if @task.update(task_params_for_update)
      redirect_to tasks_url, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
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

  # DELETE /tasks/:id
  def destroy
    # @task is set by before_action
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed.", status: :see_other
  end


  # --- Private Helper Methods ---
  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params # For create
      params.require(:task).permit(:title, :description, :due_date)
    end

    def task_params_for_update # For update
      params.require(:task).permit(:title, :description, :due_date, :completed)
    end

    def record_not_found
      redirect_to tasks_path, alert: "Task not found."
    end

end # End of class TasksController