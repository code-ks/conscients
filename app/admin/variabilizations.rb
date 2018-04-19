# frozen_string_literal: true

ActiveAdmin.register Variabilization do
  menu parent: I18n.t('i18n.product_management')

  permit_params :product_sku_id, :variant_id
end
