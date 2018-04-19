# frozen_string_literal: true

# == Schema Information
#
# Table name: tree_plantations
#
#  id                    :integer          not null, primary key
#  project_name          :string           not null
#  project_type          :string
#  plantation_uuid       :string           not null
#  base_certificate_uuid :string           not null
#  lat                   :decimal(11, 8)   not null
#  long                  :decimal(11, 8)   not null
#  tree_specie           :string           not null
#  producer_name         :string           not null
#  trees_quantity        :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class TreePlantation < ApplicationRecord
  has_many :line_items, dependent: :destroy

  extend Mobility
  translates :project_type

  validates :project_name, :project_type, :plantation_uuid, :base_certificate_uuid,
            :lat, :long, :tree_specie, :producer_name, :tree_quantity
end
