class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  skip_before_action :check_sec_login, only: [:create]

  # GET /sessions
  # GET /sessions.json
  def index
    if params[:only] == "in"
      @only = "in"
      @sessions = Session.where(employee: current_employee, state: "in")
    elsif params[:only] == "out"
      @only = "out"
      @sessions = Session.where(employee: current_employee, state: "out")
    else
      @sessions = Session.where(employee: current_employee)
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    employee = Employee.find_by(email: login_params[:email])
    
    if employee.present?
      if employee.password == login_params[:password]
        helpers.log_in(employee, request.headers["User-Agent"], request.remote_ip)
        redirect_to '/me'
      else
        redirect_to '/employees/login', notice: "The password you entered is incorrect"
      end
    else
      redirect_to '/employees/login', notice: "The email you entered is incorrect"
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    helpers.log_out @session
    respond_to do |format|
      format.html { redirect_to login_employees_path, notice: 'Successfully logged out.' }
      format.json { head :no_content }
    end
  end

  def destroy_all
    current_employee.sessions.destroy_all
    helpers.expire_session
    respond_to do |format|
      format.html { redirect_to login_employees_path, notice: 'Successfully logged out.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:state, :state, :employee_id)
    end

    def login_params
      params.require(:session).permit(:email, :password)
    end
end
