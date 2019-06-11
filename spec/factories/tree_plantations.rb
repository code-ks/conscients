# frozen_string_literal: true

FactoryBot.define do
  factory :tree_plantation do
    trees_quantity { 100 }
    project_name { 'Amazonia' }
    project_type { 'type type' }
    partner { 'La Fondacion' }
    latitude { 0.434079e2 }
    longitude { 0.37008e1 }
    base_certificate_uuid { '95GHJKVEKZBV9' }
  end
end
