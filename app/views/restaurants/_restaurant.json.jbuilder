json.extract! restaurant, :id, :title, :description, :user_id, :address, :telephone, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
