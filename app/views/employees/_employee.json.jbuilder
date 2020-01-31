json.extract! employee, :id, :names, :email, :idcard, :password, :admin, :position, :created_at, :updated_at
json.url employee_url(employee, format: :json)
