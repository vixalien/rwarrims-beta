module ApplicationHelper
	def generateuniquesecure
    secure = SecureRandom.base64(100)
    if Session.find_by(cookie: secure)
      secure = generateuniquesecure
    end
    secure
  end

  def time_ago ttime
    a = ""
    def append_about a
      a = ("about "<<a) unless a.start_with? "about"
    end
    if ttime/31104000 > 1
      append_about a
      a << (ttime/31104000).to_i.to_s
      a << " years "
    end
    if ttime/2592000 > 1
      ttime%=31104000
      append_about a
      a << (ttime/2592000).to_i.to_s
      a << " months "
    end
    if ttime/86400 > 1
      ttime%=2592000
      a << (ttime/86400).to_i.to_s
      a << " days "
    end
    if (ttime/3600) > 1
      ttime%=86400
      a << (ttime/3600).to_i.to_s
      a << " hours "
    end
    if (ttime/60) > 1
      ttime%=3600
      a << (ttime/60).to_i.to_s
      a << " minutes "
    end
    if (ttime) > 3
      ttime%=60
      a << (ttime).to_i.to_s
      a << " seconds"
    else
      a << "about 0 seconds"
    end
    a
  end

  def get_loc ip
    ip = "41.186.83.143" if (ip == "::1" || ip == "127.0.0.1")
    a = HTTP.get("http://www.geoplugin.net/json.gp", params: {ip: ip})
    a = JSON.parse(a)
    g = "geoplugin"
    { country: a["#{g}_countryName"], city: a["#{g}_city"], ip: a["#{g}_request"], lat: a["#{g}_latitude"], long: a["#{g}_longitude"], state: a["#{g}_region"] }
  end

  def get_ua useragent
    { os: useragent.split("(")[1].split(")")[0], browser: useragent.split("(").last.split(")").last.split(" ").first.gsub("/", " version "), full: useragent }
  end

  def log_in employee, useragent, ip
    s = employee.sessions.new(state: "in", cookie: generateuniquesecure)
    ua = s.build_useragent(get_ua(useragent))
    cookies.encrypted[:ss_id] = {value: s.cookie,expires: Time.now + (60*60*24*10)}
    s.build_location()
    s.loc_updated_at = DateTime.now
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
