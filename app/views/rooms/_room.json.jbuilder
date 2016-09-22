json.extract! room, :id, :location, :name, :size, :created_at, :updated_at
json.url room_url(room, format: :json)