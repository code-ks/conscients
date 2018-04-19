# frozen_string_literal: true

ActiveAdmin.register Variant do
  config.sort_order = 'position_asc'

  permit_params :category, :value, :position
end
