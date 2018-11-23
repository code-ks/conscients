# frozen_string_literal: true

class Checkout::PaymentsController < ApplicationController
  def new; end

  def create_stripe
    CreateStripePayment.new(@cart, params[:stripe_token]).perform
    redirect_to payment_path(@cart)
    # redirect_to payment_path(@cart), notice: t('flash.payments.create.notice')
  rescue Stripe::CardError
    redirect_to new_payment_path, alert: t('flash.payments.create.alert')
  end

  def create_paypal
    redirect_url = CreatePaypalPayment.new(@cart).perform_creation
    redirect_to redirect_url
  rescue PayPalError
    redirect_to new_payment_path, alert: t('flash.payments.create.alert')
  end

  def create_bank_transfer
    @cart.bank_transfer!
    @cart.order_by_bank_transfer!
    @cart.update(total_price: @cart.ttc_price_all_included)
    ClientMailer.with(order: @cart).bank_account_details.deliver_later
    # redirect_to payment_path(@cart), notice: t('flash.payments.create_bank_transfer.notice')
    redirect_to payment_path(@cart)
  end

  def paypal_success
    CreatePaypalPayment.new(@cart, params).perform_execution
    redirect_to payment_path(@cart), notice: t('flash.payments.create.notice')
  rescue PayPalError
    redirect_to new_payment_path, alert: t('flash.payments.create.alert')
  end

  def show
    @order = Order.find(params[:id])
  end
end
