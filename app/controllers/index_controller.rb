class IndexController < ApplicationController
  skip_before_action :check_sec_login, except: :admin
  def index
    if helpers.logged_in?
      render layout: "layouts/application"
    else
      render "employees/login", layout: "layouts/outside"
    end
  end

  def about
  end

  def faq
  end

  def issue
  end

  def help
  end

  def admin
    render layout: "layouts/admin"
  end
end
