# frozen_string_literal: true

class Checkout::PaymentsController < ApplicationController
  before_action

  def new; end

  def create
    CreateStripePayment.new(@cart, params[:stripe_token]).perform if params[:stripe_token]
    @cart.paid!
    redirect_to root_path, notice: 'Youpi'
  rescue Stripe::CardError => e
    redirect_to new_payment_path, alert: e.message
  end
end
