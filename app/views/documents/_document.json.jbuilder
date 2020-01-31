json.extract! document, :id, :title, :approved, :approved_by, :employee_id, :created_at, :updated_at
json.url document_url(document, format: :json)
