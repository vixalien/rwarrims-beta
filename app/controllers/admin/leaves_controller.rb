class Admin::LeavesController < AdminController
  before_action :set_leave, only: [:show, :edit, :update, :destroy, :recommend, :change]

  # GET /leaves
  # GET /leaves.json
  def index
    if params[:employee].to_i != 0
      @employee = Employee.find(params[:employee].to_i)
      @n = "#{@employee.names}'s"
    else
      @employee = Employee.all
      @n = "Total"
    end
    if params[:recommended].to_i == 1
      @status = "recommended"
      @leaves = Leave.where(employee: @employee, recommended: true)
    elsif params[:approved].to_i == 1
      @status = "approved"
      @leaves = Leave.where(employee: @employee, approved: true)
    else
      @status = ""
      @leaves = Leave.where(employee: @employee)
    end
  end

  def show
  end

  def recommend
    @p = helpers.current_employee.position
  end

  def destroy
  end

  def edit
  end

  def change
    respond_to do |format|
      @leave.recommended = change_params[:recommended]
      @leave.approved = change_params[:approved]
      if change_params[:recommended] == "1"
        @leave.recommended_by = helpers.current_employee.id
        @leave.date_recommended = DateTime.now
      end
      if change_params[:approved] == "1"
        if helpers.current_employee.position.to_i != 6
          @leave.errors.add(:base,"Only Executive Director can approve leaves")
        else
          @leave.approved_by = helpers.current_employee.id
          @leave.date_approved = DateTime.now
        end
      end
      if @leave.save
        format.html { redirect_to admin_leave_path(@leave), notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @leave.update(leave_params)
        format.html { redirect_to admin_leave_path(@leave), notice: 'Leave was successfully updated.' }
        format.json { render :show, status: :ok, location: @leave }
      else
        format.html { render :edit }
        format.json { render json: @leave.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leave
      @leave = Leave.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leave_params
      params.require(:leave).permit(:reason, :start, :end, :expected, :category)
    end

    def change_params
      params.require(:leave).permit(:recommended, :approved)
    end
end
