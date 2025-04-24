# app/controllers/tasks_controller.rb
class TasksController < ApplicationController

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      # Redirect to the index page on success
      redirect_to tasks_url, notice: "Task was successfully created."
    else
      # Re-render the 'new' form with errors and correct status code
      render :new, status: :unprocessable_entity
    end
  end

  # --- Add other actions (show, edit, update, destroy) later ---

  private # <--- Only ONE private section needed

    # Use callbacks to share common setup or constraints between actions.
    # Example (uncomment when needed):
    # def set_task
    #   @task = Task.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :due_date)
      # Note: We don't permit :completed on create, it defaults to false
    end

end # <--- This is now the correct final 'end' for the class