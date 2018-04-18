# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  ancestry   :string
#  position   :integer
#

class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy

  has_ancestry
  acts_as_list scope: [:ancestry]

  extend Mobility
  translates :slug, :name

  extend FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  validates :name, presence: true, length: { minimum: 3, maximum: 40 }
  validates :slug, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }

  default_scope { i18n.friendly.in_order }
  scope :in_order, -> { order(position: :asc) }
  scope :main, -> { home.children }

  def self.home
    roots.first
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def products
    Product.includes(:categorizations).where(categorizations: { category: subtree })
  end
end
