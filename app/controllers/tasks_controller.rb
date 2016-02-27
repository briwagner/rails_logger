class TasksController < ActionController::Base

  layout 'application'

  def index

  end

  def show
    @task = Task.find(params[:id])
    @employer = Employer.find(@task.employer_id)
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task].permit(:description, :time_in, :time_out))
    if @task.save
      flash[:notice] = "Task updated"
      # redirect_to task_path(@task)
      redirect_to employer_show_path(@task.employer)
    else
      flash[:notice] = "Failed to save"
      redirect_to task_path(@task)
    end

  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "New task saved"
      redirect_to "/employers/#{@task.employer_id}"
    else
      flash[:notice] = "Failed to save"
      redirect_to "/employers/#{@task.employer_id}"
    end
  end

  def open
    @open_tasks = Task.where(time_out: nil)
  end

  private

  def task_params
    params.require(:task).permit(:employer_id, :description, :time_in, :time_out)
  end

end