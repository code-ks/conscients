# frozen_string_literal: true

class LinkDeliveryInfoToCart
  def initialize(cart, order_params, addresses_params)
    @cart = cart
    @client = @cart.client
    @order_params = order_params
    @delivery_address_params =
      addresses_params[:delivery_address].merge(address_type: addresses_params[:address_type])
    @billing_address_params = addresses_params[:billing_address]
    @delivery_is_billing = addresses_params[:delivery_is_billing] == '1'
  end

  def perform
    find_or_initialize_delivery_address
    find_or_initialize_billing_address
    add_delivery_information_to_cart
    manage_postal_address_type
    [@cart, @delivery_address, @billing_address]
  end

  private

  def find_or_initialize_delivery_address
    @delivery_address = @client.addresses.find_or_initialize_by(@delivery_address_params)
  end

  def find_or_initialize_billing_address
    @billing_address =
      if @delivery_is_billing
        @delivery_address
      else
        @client.addresses.find_or_initialize_by(@billing_address_params)
      end
  end

  def manage_postal_address_type
    return unless @delivery_address.postal?

    if @delivery_address == @billing_address
      @delivery_address.postal_address_type = nil
    else
      @delivery_address.postal_address_type = 'delivery'
      @billing_address.postal_address_type = 'billing'
    end
  end

  def add_delivery_information_to_cart
    @cart.assign_attributes(@order_params)
    @cart.assign_attributes(delivery_address: @delivery_address, billing_address: @billing_address)
  end
end
