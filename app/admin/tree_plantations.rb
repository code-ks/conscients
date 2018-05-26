# frozen_string_literal: true

ActiveAdmin.register TreePlantation do
  menu parent: I18n.t('active_admin.product_management')

  permit_params :project_name, :project_type_fr, :project_type_en, :partner, :plantation_uuid,
                :color_certificate, :base_certificate_uuid, :latitude, :longitude,
                :tree_specie, :producer_name, :trees_quantity

  index do
    selectable_column
    id_column
    column :project_name
    column :project_type_fr
    column :project_type_en
    column :partner
    column :plantation_uuid
    column :color_certificate
    column :base_certificate_uuid
    column :latitude
    column :longitude
    column :tree_specie
    column :producer_name
    column :trees_quantity
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    inputs do
      f.input :project_name
      f.input :project_type_fr
      f.input :project_type_en
      f.input :partner
      f.input :plantation_uuid
      f.input :color_certificate
      f.input :base_certificate_uuid
      f.input :latitude
      f.input :longitude
      f.input :tree_specie
      f.input :producer_name
      f.input :trees_quantity
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :project_name
      row :project_type_fr
      row :project_type_en
      row :partner
      row :plantation_uuid
      row :color_certificate
      row :base_certificate_uuid
      row :latitude
      row :longitude
      row :tree_specie
      row :producer_name
      row :trees_quantity
      row :created_at
      row :updated_at
    end
  end
end
