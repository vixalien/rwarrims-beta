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
  end

  def current_employee
    helpers.current_employee
  end

  def current_session
    helpers.current_session
  end
end
