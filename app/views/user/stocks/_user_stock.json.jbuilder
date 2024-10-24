json.extract! user_stock, :id, :product_id, :amount, :size, :created_at, :updated_at
json.url user_stock_url(user_stock, format: :json)
