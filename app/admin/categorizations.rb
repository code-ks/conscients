# frozen_string_literal: true

ActiveAdmin.register Categorization do
  permit_params :product_id, :category_id

  includes :product, :category
end
