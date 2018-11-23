# frozen_string_literal: true

class CreateStripePayment
  def initialize(cart, stripe_token)
    @cart = cart
    @stripe_token = stripe_token
  end

  def perform
    create_customer
    @charge = create_charge
    update_order
  end

  private

  def create_customer
    if @cart.client_stripe_customer_id
      Stripe::Customer.retrieve(@cart.client_stripe_customer_id)
    else
      customer = Stripe::Customer.create(
        source: @stripe_token,
        email:  @cart.client_email
      )
      @cart.client.update(stripe_customer_id: customer.id)
    end
  end

  def create_charge
    Stripe::Charge.create(
      customer: @cart.client_stripe_customer_id,
      amount: @cart.ttc_price_all_included_cents,
      description:  "Payment for order ##{@cart.id}",
      currency: 'eur'
    )
  end

  def update_order
    @cart.stripe!
    @cart.update(payment_details: @charge.to_json)
    @cart.pay!
  end
end
