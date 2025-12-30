json.extract! employee, :id, :full_name, :job_title, :country, :salary, :created_at, :updated_at
json.url employee_url(employee, format: :json)
