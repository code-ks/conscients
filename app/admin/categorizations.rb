# frozen_string_literal: true

ActiveAdmin.register Categorization do
  menu parent: I18n.t('i18n.product_management')

  permit_params :product_id, :category_id

  includes :product, :category

  form do |f|
    f.semantic_errors
    inputs do
      f.input :product
      f.input :category, as: :select, selected: object.category,
      collection: Category.all.collect(&:to_s)
    end
    f.actions
  end
end
