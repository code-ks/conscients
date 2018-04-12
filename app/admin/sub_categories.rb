# frozen_string_literal: true

ActiveAdmin.register SubCategory do
  includes :category
end
