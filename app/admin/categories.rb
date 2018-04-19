# frozen_string_literal: true

ActiveAdmin.register Category do
  config.sort_order = 'position_asc'

  permit_params :name, :slug, :name_en, :slug_en, :parent, :positon

  includes :text_translations

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    id_column
    column :name_fr
    column :name_en
    column :slug_fr
    column :slug_en
    column :ancestry
    column :position
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
      f.input :parent, as: :select, collection: Category.all.collect(&:to_s)
      f.input :postion
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
      row :ancestry
      row :position
      row :created_at
      row :updated_at
    end
  end
end
