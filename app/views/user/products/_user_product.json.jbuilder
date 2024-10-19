json.extract! user_product, :id, :name, :description, :price, :category_id, :active, :created_at, :updated_at
json.url user_product_url(user_product, format: :json)
