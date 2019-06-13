# frozen_string_literal: true

# == Schema Information
#
# Table name: tree_plantations
#
#  id                    :bigint(8)        not null, primary key
#  project_name          :string           not null
#  project_type          :string
#  partner               :string           not null
#  plantation_uuid       :string
#  base_certificate_uuid :string           not null
#  latitude              :decimal(11, 8)   not null
#  longitude             :decimal(11, 8)   not null
#  tree_specie           :string
#  producer_name         :string
#  trees_quantity        :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  base_tree_quantity    :integer
#  is_full               :boolean          default(FALSE)
#  certificate_counter   :integer          default(0), not null
#

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
