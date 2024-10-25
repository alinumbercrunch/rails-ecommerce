json.extract! user_order, :id, :customer_email, :fullfilled, :total, :address, :created_at, :updated_at
json.url user_order_url(user_order, format: :json)
