# frozen_string_literal: true

# == Schema Information
#
# Table name: tree_plantations
#
#  id                    :bigint(8)        not null, primary key
#  project_name          :string           not null
#  project_type          :string
#  partner               :string           not null
#  plantation_uuid       :string           not null
#  color_certificate     :string           not null
#  base_certificate_uuid :string           not null
#  latitude              :decimal(11, 8)   not null
#  longitude             :decimal(11, 8)   not null
#  tree_specie           :string           not null
#  producer_name         :string           not null
#  trees_quantity        :integer          default(0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  base_tree_quantity    :integer
#

class TreePlantation < ApplicationRecord
  has_many :line_items, dependent: :destroy

  before_create :match_base_tree_quantity

  extend Mobility
  translates :project_type

  validates :project_name, :project_type, :plantation_uuid, :base_certificate_uuid,
            :latitude, :longitude, :tree_specie, :producer_name, :trees_quantity, :partner,
            :color_certificate, presence: true
  validates :base_certificate_uuid, length: { maximum: 15 }
  validates :project_name, :project_type, :plantation_uuid, :tree_specie, :producer_name,
            :partner, length: { maximum: 40 }
  validates :trees_quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :color_certificate, format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ }

  default_scope { in_order }
  scope :in_order, -> { order(trees_quantity: :asc) }

  alias_attribute :quantity, :trees_quantity

  class << self
    def first_with_needed_quantity(quantity)
      find_by('trees_quantity > ?', quantity) || last
    end
  end

  def marker(client)
    line_items.finished.where(orders: { client: client }).tree_plantation_marker
  end

  def to_s
    project_name
  end

  def generate_certificate_number
    base_certificate_uuid + "-#{format '%03d', base_tree_quantity - trees_quantity + 1}"
  end

  def match_base_tree_quantity
    self.base_tree_quantity = trees_quantity
  end
end
