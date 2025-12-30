class EmployeesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]
  before_action :set_employee, only: %i[ show edit update destroy calculate_net_salary ]

  rescue_from ActionController::ParameterMissing, with: :render_param_missing

  # GET /employees or /employees.json
  def index
    @employees = Employee.all
    respond_to do |format|
      format.html # renders index.html.erb
      format.json { render json: @employees }
    end
  end

  # GET /employees/1 or /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees or /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: "Employee was successfully created." }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1 or /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: "Employee was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1 or /employees/1.json
  def destroy
    @employee.destroy!

    respond_to do |format|
      format.html { redirect_to employees_path, notice: "Employee was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def calculate_net_salary
    debugger
    if @employee.country == "India"
      taxes = @employee.salary/10
    elsif @employee.country == "US"
      taxes = @employee.salary/5
    else
      taxes = 0
    end
    render json: { employee_id: @employee.id, net_salary: (@employee.salary - taxes) }
  end

  def min_max_salary_in_country
    country = params.require(:country)
    min_salary = Employee.where(country: country).minimum(:salary)
    max_salary = Employee.where(country: country).maximum(:salary)
    render json: { country: country, min_salary: min_salary, max_salary: max_salary }
  end

  def avg_salary_by_job_title
    job_title = params.require(:job_title)
    avg_salary = Employee.where(job_title: job_title).average(:salary)
    render json: { job_title: job_title, avg_salary: avg_salary }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:full_name, :job_title, :country, :salary)
    end

    def render_param_missing(exception)
      render json: { error: exception.message }, status: :bad_request
    end
end
