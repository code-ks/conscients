# frozen_string_literal: true

ActiveAdmin.register ProductSku do
  menu parent: I18n.t('active_admin.product_management')

  actions :all, except: %i[edit update]

  index do
    selectable_column
    id_column
    column :product_sku, &:to_s
    column :sku
    column :quantity
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :product_sku
      row :sku
      row :quantity
      row :created_at
      row :updated_at
    end
  end
end
