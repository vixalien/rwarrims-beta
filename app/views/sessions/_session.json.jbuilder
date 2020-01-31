json.extract! session, :id, :state, :text, :employee_id, :created_at, :updated_at
json.url session_url(session, format: :json)
