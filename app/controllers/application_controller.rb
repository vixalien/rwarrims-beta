class ApplicationController < ActionController::Base
  before_action :update_session
  before_action :check_sec_login
  before_action :set_controller_name

	def check_sec_login
    case helpers.verbose_logged_in?
    when true
      true
    when "signed out"
      redirect_to "/employees/login", notice: "You have been signed out, you need to sign in again." and return
    when "invalid"
      redirect_to "/employees/login", notice: "An error occurred, please log in again." and return
    when false
      redirect_to "/employees/login", notice: "You are must first be logged in." and return
    end
  end

  def set_admin_layout
    render layout: "layouts/admin"
  end

  def set_controller_name
    @controller = controller_name
  end

  def update_session
    if helpers.logged_in?
      helpers.current_session.update(updated_at: DateTime.now)
    end
    # Get a new location if 10 minutes have elapsed
    if DateTime.now.to_i - helpers.current_session.loc_updated_at.to_i > (60 * 10)
      s = helpers.current_session
      if !s.location.present?
        s.build_location
      end
      s.location.update(helpers.get_loc request.ip)
      s.loc_updated_at = DateTime.now
      s.save
    end
  end

  def current_employee
    helpers.current_employee
  end

  def current_session
    helpers.current_session
  end
end
