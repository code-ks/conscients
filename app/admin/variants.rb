# frozen_string_literal: true

ActiveAdmin.register Variant do
  menu parent: I18n.t('active_admin.product_management')

  config.sort_order = 'position_asc'

  permit_params :category, :value_fr, :value_en, :position

  index do
    selectable_column
    id_column
    column :value_fr
    column :value_en
    column :position
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      f.input :value_fr
      f.input :value_en
      f.input :position
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :value_fr
      row :value_en
      row :position
      row :created_at
      row :updated_at
    end
  end
end
