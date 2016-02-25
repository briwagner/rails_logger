class EmployersController < ActionController::Base

  layout 'application'

  def index
    @employers = Employer.all
    @open_tasks = Task.where(time_out: nil)
  end

  def new
    @employer = Employer.new
  end

  def show
    @employer = Employer.find(params[:id])
    @task = Task.new
  end

  def manage
    @employers = Employer.all
  end

  def update
    employer = Employer.find(params[:id])
    if employer.update_attributes(params[:employer].permit(:rate, :name))
      flash[:notice] = "Updated employer"
    else
      flash[:notice] = "Failed to update employer"
    end
    redirect_to employers_path
  end

  def delete
    @employer = Employer.find(params[:id])
    if @employer.destroy
      respond_to do |format|
        format.json {render json: {id: @employer.id, text: "Removed #{@employer.name}"} }
        format.html { redirect_to employers_path }
      end
    else
      format.text {render text: "Failed to delete #{@employer.name}"}
    end
  end

  def create
    @employer = Employer.new(employer_params)
    if @employer.save
      flash[:notice] = "New employer #{@employer.name} saved"
      redirect_to action: 'index'
    else
      flash[:notice] = "Failed to save"
      render "new"
    end
  end

  private

  def employer_params
    params.require(:employer).permit(:name, :rate)
  end

end
