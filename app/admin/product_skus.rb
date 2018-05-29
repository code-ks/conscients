# frozen_string_literal: true

ActiveAdmin.register ProductSku do
  menu parent: I18n.t('active_admin.product_management')

  permit_params :product_id, :sku_id

  actions :all, except: %i[edit update destroy]

  index do
    selectable_column
    id_column
    column :product, &:to_s
    column :sku
    column :quantity
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :product
      row :sku
      row :quantity
      row :created_at
      row :updated_at
    end
  end
end
