json.extract! storedfile, :id, :name, :data, :todo_id, :created_at, :updated_at
json.url storedfile_url(storedfile, format: :json)
