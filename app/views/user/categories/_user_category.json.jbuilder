json.extract! user_category, :id, :name, :description, :created_at, :updated_at
json.url user_category_url(user_category, format: :json)
