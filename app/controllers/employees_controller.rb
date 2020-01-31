class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_sec_login, only: :login

  # GET /employees/login
  def login
    if helpers.logged_in?
      @emp = current_employee
    end
    render layout: "layouts/outside"
  end

  # GET /me
  # GET /me.json
  def show
    @current_session = current_session
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    render layout: "layouts/outside"
  end

  # GET /employees/me/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      @employee.admin = false
      @employee.position = 7
      @employee.head = false
      if @employee.save
        format.html { redirect_to @employee, notice: 'Your account was successfully created. Waiting for admins to confirm' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/me
  # PATCH/PUT /employees/me.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to me_path, notice: 'Your account was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/me
  # DELETE /employees/me.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Your account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = current_employee
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:names, :email, :idcard, :password, :admin, :position, :password_confirmation)
    end
end
