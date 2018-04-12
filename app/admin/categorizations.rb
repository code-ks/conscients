# frozen_string_literal: true

ActiveAdmin.register Categorization do
  permit_params :product_id, :sub_category_id

  includes :product, :sub_category
end
