class Admin::AttendancesController < AdminController
  def index
  	if params[:employee].to_i != 0
      @employee = Employee.find(params[:employee].to_i)
    else
      @employee = helpers.current_employee
    end
    @n = "#{@employee.names}'s"
  	@action_name = "all"
    @attendances = @employee.attendances.all
    filter_params = params[:date]
    if filter_params
      @new_day = Date.civil(filter_params[:year].to_i || DateTime.now.year, filter_params[:month].to_i || DateTime.now.month, filter_params[:day].to_i || DateTime.now.day)
      if filter_params[:scope] == "month"
        @status = "monthly"
        @old_day = @new_day.beginning_of_month
      else
        @status = "weekly"
        @old_day = @new_day.beginning_of_week
      end
    else
      @status = "weekly"
      @new_day = Date.today
      @old_day = 7.days.ago.to_date
    end
  end
end
