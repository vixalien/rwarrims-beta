json.extract! employee, :names, :email, :idcard, :admin
json.department getDepartmentId employee.department
json.position getPositionId employee.position
json.url employee_url(employee, format: :json)
