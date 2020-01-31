module ApplicationHelper
	def generateuniquesecure
    secure = SecureRandom.base64(100)
    if Session.find_by(cookie: secure)
      secure = generateuniquesecure
    end
    secure
  end

  def log_in employee, useragent, ip
    s = employee.sessions.new(state: "in", cookie: generateuniquesecure)
    ua = s.build_useragent(os: useragent.split("(")[1].split(")")[0], browser: useragent.split("(").last.split(")").last.split(" ").first.gsub("/", " version "), full: useragent )
    cookies.encrypted[:ss_id] = {value: s.cookie,expires: Time.now + (60*60*24*10)}
    ua.save
    s.save
  end

  def verbose_logged_in?
    ss_id = cookies.encrypted[:ss_id]
    session = Session.find_by(cookie: ss_id)
    if session.present?
      if session.state == "in"
        employee = session.employee
        if session.employee.present?
          true
        else
          "invalid"
        end
      else
        "signed out"
      end
    else
      false
    end
  end

  def logged_in?
    verbose_logged_in? == true ? true : false
  end
  
  def current_employee
    if verbose_logged_in? == true
      current_session.employee
    else
      ""
    end
  end

  def current_session
    if verbose_logged_in? == true
      Session.find_by(cookie: cookies.encrypted[:ss_id])
    else
      ""
    end
  end

  def log_out session
    session.update(state: "out")
  end

  def expire_session
    cookies.encrypted[:ss_id] = { value: nil, expires: Time.now - 1.day }
  end
end
