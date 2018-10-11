# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  slug         :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ancestry     :string
#  position     :integer
#  home_display :integer
#

class Category < ApplicationRecord
  has_many :categorizations, dependent: :destroy

  before_destroy :stop_destroy

  has_ancestry
  acts_as_list scope: [:ancestry]

  extend Mobility
  translates :slug, :name, :description

  extend FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  validates :name, presence: true, length: { minimum: 3, maximum: 40 }
  validates :slug, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }
  validates :home_display, uniqueness: true, allow_nil: true

  default_scope { i18n.friendly.in_order }
  scope :in_order, -> { order(position: :asc) }
  scope :main, -> { home.children }

  class << self
    def last_visited
      find(Ahoy::Event.id_last_category_visited)
    rescue ::ActiveRecord::RecordNotFound
      Category.home
    end
  end

  def to_s
    "#{id} - #{name}".tap do |string|
      string += "parent: #{parent&.name}" if parent
    end
  end

  def self.home
    roots.first
  end

  def self.give_a_tree
    find_by(slug: 'gifts-give-a-tree')
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def products
    Product.includes(:categorizations).where(categorizations: { category: subtree })
  end

  def variants
    Variant.includes(:text_translations, :product_skus)
           .where(product_skus: { product: products })
  end
end
