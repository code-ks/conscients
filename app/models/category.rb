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

  has_ancestry
  acts_as_list scope: [:ancestry]

  extend Mobility
  translates :slug, :name, :description

  extend FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  validates :name_fr, :name_en, :slug_fr, :slug_en,
            presence: true, length: { minimum: 3, maximum: 40 }
  validates :slug, uniqueness: true
  validates :home_display, uniqueness: true, allow_nil: true

  default_scope { i18n.friendly }
  scope :in_order, -> { order(position: :asc) }
  scope :in_order_home, -> { order(home_display: :asc) }
  scope :main, -> { home.children }

  # Used in the modal after adding a problem to cart
  class << self
    def last_visited
      find(Ahoy::Event.id_last_category_visited)
    rescue ::ActiveRecord::RecordNotFound
      Category.home
    end
  end

  # Displays styled name in admin
  def to_s
    "#{id} - #{name}".tap do |string|
      string += "parent: #{parent&.name}" if parent
    end
  end

  def self.home
    roots.first
  end

  # All categories with at least one displayable product
  def self.displayable
    all.to_a.select do |category|
      category.products.displayable.any?
    end
  end

  # Be careful, need a slug with this exact title in the app
  def self.give_a_tree
    find_by(slug: 'gifts-give-a-tree')
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  # Cf act_as_lists gem doc to understand subtree. I could not use as many through
  # because I also want the product linked to a child category, not only the curant ones
  def products
    Product.includes(:categorizations).where(categorizations: { category: subtree })
  end

  def variants
    Variant.includes(:text_translations, :product_skus)
           .where(product_skus: { product: products.displayable })
  end
end
