# frozen_string_literal: true

ActiveAdmin.register StockEntry do
  menu parent: I18n.t('active_admin.product_management')

  actions :all, except: %i[edit update destroy]

  permit_params :product_sku_id, :quantity

  includes :product_sku
end
