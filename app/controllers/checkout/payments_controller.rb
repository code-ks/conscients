# frozen_string_literal: true

class Checkout::PaymentsController < ApplicationController
  def new; end

  def create
    case params[:payment_method]
    when 'stripe'
      manage_stripe_payments
    when 'paypal'
      manage_paypal_payments
    else
      redirect_to new_payment_path, alert: t('flash.payments.create.alert')
    end
  rescue Stripe::CardError, PayPalError
    redirect_to new_payment_path, alert: t('flash.payments.create.alert')
  end

  def paypal_success
    CreatePaypalPayment.new(@cart, params).perform_execution
    redirect_to root_path, notice: t('flash.payments.create.notice')
  rescue PayPalError
    redirect_to new_payment_path, alert: t('flash.payments.create.alert')
  end

  private

  def manage_stripe_payments
    CreateStripePayment.new(@cart, params[:stripe_token]).perform
    redirect_to root_path, notice: t('flash.payments.create.notice')
  end

  def manage_paypal_payments
    redirect_url = CreatePaypalPayment.new(@cart).perform_creation
    redirect_to redirect_url
  end
end
