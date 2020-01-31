class Admin::EmployeesController < AdminController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :recruit]
  
  # GET /employees
  # GET /employees.json
  def index
    if params[:pending].to_i == 1
      @status = "Pending"
      @employees = Employee.where(position: 7)
    elsif params[:accepted].to_i == 1
      @status = "Accepted"
      @employees = Employee.where.not(position: 7)
    else
      @status = ""
      @employees = Employee.all
    end
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/1/recruit
  def recruit
  end

  # GET /employees/1/edit
  def edit
    if params[:password] == "true"
      @password = true
    else
      @password = false
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if sec_params[:password_only] == "true"
        saved = @employee.update(password_params) 
      else
        saved = @employee.update(other_params)
      end
      if saved
        format.html { redirect_to admin_employee_path(@employee), notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_employee_path(@employee) }
      else
        if params[:password] == "true"
          @password = true
        else
          @password = false
        end
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to admin_employee_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      if params[:id] == "me"
        @employee = current_employee
      else
        @employee = Employee.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sec_params
      params.require(:employee).permit(:password_only)
    end
    def employee_params
      params.require(:employee).permit(:names, :email, :idcard, :password, :admin, :head, :position, :department, :password_confirmation)
    end
    def other_params
      params.require(:employee).permit(:names, :email, :idcard, :admin, :head, :position, :department)
    end
    def password_params
      params.require(:employee).permit(:password, :password_confirmation)
    end
end
