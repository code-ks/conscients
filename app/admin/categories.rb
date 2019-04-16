# frozen_string_literal: true

ActiveAdmin.register Category do
  menu parent: I18n.t('active_admin.product_management')

  config.sort_order = 'position_asc'

  permit_params :name_fr, :slug_fr, :name_en, :slug_en, :position, :description_fr, :description_en,
                :ancestry, :home_display

  includes :text_translations

  controller do
    # clear blank attr on save
    def save_resource(object)
      object.ancestry = nil if object.ancestry == ''
      super
    end
  end

  index do
    selectable_column
    id_column
    column :name_fr
    column :name_en
    column :slug_fr
    column :slug_en
    column :description_fr
    column :description_en
    column :ancestry
    column :position
    column :home_display
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      f.input :name_fr
      f.input :name_en
      f.input :slug_fr
      f.input :slug_en
      f.input :description_fr
      f.input :description_en
      f.input :ancestry
      f.input :position
      f.input :home_display
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name_fr
      row :name_en
      row :slug_fr
      row :slug_en
      row :description_fr
      row :description_en
      row :ancestry
      row :position
      row :home_display
      row :created_at
      row :updated_at
    end
  end
end
