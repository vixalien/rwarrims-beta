class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    @action_name = "all"
    @attendances = current_employee.attendances
    filter_params = params[:date]
    if filter_params
      @d = Date.civil(filter_params[:year].to_i || DateTime.now.year, filter_params[:month].to_i || DateTime.now.month, filter_params[:day].to_i || DateTime.now.day)
      if filter_params[:scope] == "month"
        @status = "monthly"
        @old_day = @d.beginning_of_month
        @new_day = @d.end_of_month
      else
        @status = "weekly"
        @old_day = @d.beginning_of_week
        @new_day = @d.end_of_week
      end
    else
      @status = "weekly"
      @old_day = DateTime.now.beginning_of_week
      @new_day = DateTime.now
    end
    @d ||= Date.today
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @action_name = "status"
    @attendance = current_employee.attendances.last
  end

  # GET /attendances/1/edit
  def edit
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = current_employee.attendances.last
    if @attendance
      if @attendance.state == "in"
        @attendance.state = "out"
      else
        @attendance = current_employee.attendances.new(state: "in")
      end
    else
      @attendance = current_employee.attendances.new(state: "in")
    end

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to new_attendance_path, notice: "Successfully checked #{@attendance.state}" }
        format.json { render :show, status: :created, location: new_attendance_path }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:state, :employee_id)
    end
end
