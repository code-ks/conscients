# frozen_string_literal: true

class Checkout::DeliveriesController < ApplicationController
  before_action :authenticate_client!

  def new
    redirect_to cart_path(@cart) if @cart.empty?
    update_cart_delivery_type if params['delivery_type']
    @delivery_address =
      @cart.email? ? @cart.set_email_delivery_address : @cart.set_postal_delivery_address
    @billing_address = @cart.set_billing_address
  end

  def create
    @cart, @delivery_address, @billing_address =
      LinkDeliveryInfoToCart.new(@cart, order_params, addresses_params)
                            .perform
    if @delivery_address.save && @billing_address.save && @cart.save
      redirect_to new_payment_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:recipient_message, :customer_note,
                                  line_items_attributes: %i[id delivery_email])
  end

  def addresses_params
    params.require(:order).permit(:delivery_is_billing, :address_type,
                                  delivery_address: %i[first_name last_name company address_1
                                                       address_2 city zip_code country email],
                                  billing_address: %i[first_name last_name company address_1
                                                      address_2 city zip_code country])
  end

  def update_cart_delivery_type
    if params['delivery_type'] == 'postal'
      @cart.postal!
    elsif params['delivery_type'] == 'email'
      @cart.email!
    end
  end
end
