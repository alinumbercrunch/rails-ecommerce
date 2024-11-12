require 'stripe'
# app/controllers/checkouts_controller.rb
class CheckoutsController < ApplicationController
  require 'stripe'

  def create
    stripe_secret_key = Rails.application.credentials.dig(:stripe, :STRIPE_SECRET_KEY)
    Stripe.api_key = stripe_secret_key

    cart = params[:cart]
    line_items = cart.map do |item|
      product = Product.find(item["id"])
      product_stock = product.stocks.find { |stock| stock.size == item["size"] }

      if product_stock.amount < item["quantity"].to_i
        render json: { error: "Not enough stock for #{product.name} in size #{item['size']}. Only #{product_stock.amount} left" }, status: 400
        return
      end

      {
        quantity: item["quantity"].to_i,
        price_data: {
          currency: "jpy",
          unit_amount: item["price"].to_i,
          product_data: {
            name: item["name"],
            metadata: {
              product_id: product.id,
              size: item["size"],
              product_stock_id: product_stock.id
            }
          }
        }
      }
    end

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: line_items,
      success_url: "http://localhost:3000/success",
      cancel_url: "http://localhost:3000/cancel",
      shipping_address_collection: {
        allowed_countries: ['US', 'JP']
      }
    )

    render json: { url: session.url }
  rescue => e
    Rails.logger.error("Checkout creation failed: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: "Internal Server Error" }, status: 500
  end
end
