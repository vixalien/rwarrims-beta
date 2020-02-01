class Admin::AttendancesController < AdminController
  def index
  	@action_name = "all"
    filter_params = params[:date]
    params[:employee] ||= Employee.all.ids
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
    @employees = Employee.find(params[:employee])
  end
end
