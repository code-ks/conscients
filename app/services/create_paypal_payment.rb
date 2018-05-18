# frozen_string_literal: true

class CreatePaypalPayment
  include Rails.application.routes.url_helpers

  def initialize(cart, params = {})
    @cart = cart
    @params = params
  end

  def perform_creation
    @payment = generate_paypal_payment
    raise PayPalError unless @payment.create
    @cart.update(payment_details: @payment.to_json)
    return_redirect_url
  end

  def perform_execution
    raise PayPalError unless execute_paypal_payment
    @cart.paypal!
    @cart.update(total_price: @cart.ttc_price_all_included)
    @cart.paid!
  end

  private

  def generate_paypal_payment
    PayPal::SDK::REST::Payment.new(
      intent: 'sale',
      payer: { payment_method: 'paypal' },
      redirect_urls: { return_url: paypal_success_payments_url, cancel_url: new_payment_url },
      transactions: [{
        item_list: { items: array_items_list },
        amount: { total: @cart.ttc_price_all_included.dollars, currency: 'EUR' }
      }]
    )
  end

  def array_items_list
    arr = [{ name: I18n.t('paypal.delivery_fees'), price: @cart.current_delivery_fees.dollars,
             currency: 'EUR', quantity: 1 }]
    @cart.line_items.each do |line_item|
      arr << {
        name: line_item.product_name, price: line_item.ttc_price.dollars,
        currency: 'EUR', quantity: line_item.quantity
      }
    end
    arr
  end

  def return_redirect_url
    @payment.links.find { |v| v.method == 'REDIRECT' }.href
  end

  def execute_paypal_payment
    payment_id = @params.fetch(:paymentId, nil)
    payer_id = @params.fetch(:PayerID, nil)
    payment = PayPal::SDK::REST::Payment.find(payment_id)
    payment.execute(payer_id: payer_id)
  end
end

class PayPalError < StandardError
end
