# frozen_string_literal: true

ActiveAdmin.register Variant do
  menu parent: I18n.t('active_admin.product_management')

  config.sort_order = 'position_asc'

  permit_params :category, :value, :position
end
