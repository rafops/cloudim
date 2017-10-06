json.extract! db_instance, :id, :name, :created_at, :updated_at
json.url db_instance_url(db_instance, format: :json)
