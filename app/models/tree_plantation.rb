# frozen_string_literal: true

# == Schema Information
#
# Table name: tree_plantations
#
#  id                    :integer          not null, primary key
#  project_name          :string           not null
#  project_type          :string
#  partner               :string           not null
#  plantation_uuid       :string           not null
#  base_certificate_uuid :string           not null
#  latitude              :decimal(11, 8)   not null
#  longitude             :decimal(11, 8)   not null
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
            :latitude, :longitude, :tree_specie, :producer_name, :trees_quantity, :partner,
            presence: true
  validates :trees_quantity, numericality: { greater_than_or_equal_to: 0 }

  default_scope { in_order }
  scope :in_order, -> { order(trees_quantity: :asc) }

  alias_attribute :quantity, :trees_quantity

  class << self
    def first_with_needed_quantity(quantity)
      find_by('trees_quantity > ?', quantity) || last
    end
  end

  def generate_certificate_number
    base_certificate_uuid + "-#{format '%03d', trees_quantity}"
  end
end
