# frozen_string_literal: true

ActiveAdmin.register Coupon do
  menu parent: I18n.t('active_admin.order_management')

  permit_params :product_id, :client_id, :percentage, :amount_cents, :amount_currency,
                :name, :amount_min_order_cents, :valid_from, :valid_until
end
