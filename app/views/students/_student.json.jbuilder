json.extract! student, :id, :first_name, :email, :created_at, :updated_at
json.url student_url(student, format: :json)
