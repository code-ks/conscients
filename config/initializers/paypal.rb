# frozen_string_literal: true

PayPal::SDK.configure(
  mode: Rails.env.production? ? 'live' : 'sandbox',
  client_id: Rails.application.credentials.dig(Rails.env.to_sym, :paypal_client_id),
  client_secret: Rails.application.credentials.dig(Rails.env.to_sym, :paypal_secret)
)
PayPal::SDK.logger = Rails.logger
