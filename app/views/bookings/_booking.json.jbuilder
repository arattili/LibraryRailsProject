json.extract! booking, :id, :userid, :roomid, :time_date, :created_at, :updated_at
json.url booking_url(booking, format: :json)