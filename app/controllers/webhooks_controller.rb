class WebhooksController < ApplicationController
  skip_forgery_protection

  def stripe
    stripe_secret_key = Rails.application.credentials.dig(:stripe, :STRIPE_SECRET_KEY)
    Stripe.api_key = stripe_secret_key
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    # Debugging line
    puts "Retrieved endpoint_secret: #{endpoint_secret}"

    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      render json: { error: 'Invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      puts "Webhook signature verification failed."
      render json: { error: 'Invalid signature' }, status: 400
      return
    end

    case event.type
    when "checkout.session.completed"
      session = event.data.object
      shipping_details = session["shipping_details"]
      address = if shipping_details
            "#{shipping_details['address']['line1']}, #{shipping_details['address']['city']}, #{shipping_details['address']['state']}, #{shipping_details['address']['postal_code']}"
          else
            "No shipping address provided"
          end
      order = Order.create!(customer_email: session["customer_details"]["email"], total: session["amount_total"], address: address, fullfilled: false)
      full_session = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"] })
      line_items = full_session.line_items
      line_items["data"].each do |item|
        product = Stripe::Product.retrieve(item["price"]["product"])
        product_id = product["metadata"]["product_id"].to_i
        order.order_products.create!(order: order, product_id: product_id, quantity: item["quantity"], size: product["metadata"]["size"])
        Stock.find(product["metadata"]["product_stock_id"]).decrement!(:amount, item["quantity"])
      end
    else
      puts "Unhandled event type #{event.type}"
    end

    render json: { message: "success" }
  end
end
