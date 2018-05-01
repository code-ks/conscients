# frozen_string_literal: true

class Checkout::DeliveriesController < ApplicationController
  before_action :authenticate_client!

  def new
    @delivery_type = params[:delivery_type]
    @delivery_address =
      @cart.delivery_address || current_client.addresses.first || @cart.build_delivery_address
    @billing_address =
      @cart.billing_address || current_client.addresses.first || @cart.build_billing_address
  end

  def create; end
end
