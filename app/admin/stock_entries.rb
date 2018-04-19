# frozen_string_literal: true

ActiveAdmin.register StockEntry do
  menu parent: I18n.t('i18n.product_management')

  actions :all, except: %i[edit update delete]

  permit_params :product_sku_id, :quantity

  includes :product_sku
end
