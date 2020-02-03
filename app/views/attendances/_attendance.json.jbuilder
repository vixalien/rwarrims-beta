json.extract! attendance, :id, :state
json.employee do 
	json.partial! "employees/employee", employee: attendance.employee
end
if attendance.state.downcase == "in"
	json.at attendance.created_at
	json.time_worked distance_of_time_in_words(attendance.created_at, Time.now)
else
	json.at attendance.updated_at
end
json.notice "Successfully checked #{attendance.state}"