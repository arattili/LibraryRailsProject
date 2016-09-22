json.extract! user, :id, :email, :password, :fname, :lname, :isadmin, :pers, :created_at, :updated_at
json.url user_url(user, format: :json)