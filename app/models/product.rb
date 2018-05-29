# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                       :bigint(8)        not null, primary key
#  description_short        :string
#  description_long         :text
#  product_class            :string
#  ht_price_cents           :integer          default(0), not null
#  ht_price_currency        :string           default("EUR"), not null
#  tax_rate                 :decimal(4, 2)    default(20.0), not null
#  weight                   :integer          default(0)
#  product_type             :integer          default("classic"), not null
#  published                :boolean          default(TRUE), not null
#  position                 :integer
#  ht_buying_price_cents    :integer          default(0), not null
#  ht_buying_price_currency :string           default("EUR"), not null
#  seo_title                :string
#  meta_description         :string
#  keywords                 :text             default([]), is an Array
#  slug                     :string
#  producer_latitude        :decimal(11, 8)
#  producer_longitude       :decimal(11, 8)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  name_en                  :string
#  name_fr                  :string
#

class Product < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :product_skus, dependent: :destroy
  has_many :line_items, through: :product_skus
  has_many :orders, through: :line_items
  has_many :variabilizations, through: :product_skus
  has_many :variants, through: :variabilizations
  has_many :coupons, dependent: :destroy
  has_many_attached :images
  has_one_attached :certificate_background

  extend Mobility
  translates :name, backend: :column
  translates :description_short, :description_long, :seo_title, :meta_description,
             :keywords, :slug, :product_class

  include FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  include PgSearch
  pg_search_scope :search_by_name,
                  against: %i[name_fr name_en],
                  using: { tsearch: { prefix: true } }

  acts_as_list
  monetize :ht_price_cents, :ht_buying_price_cents, :ttc_price_cents

  enum product_type: { classic: 0, personalized: 1, tree: 2 }

  validates :name_fr, :name_en, :description_short, :ht_price_cents, :product_type,
            :published, :seo_title, :meta_description, :slug, :tax_rate, presence: true
  validates :name_fr, :name_en, :slug, :seo_title, uniqueness: true
  validates :name_fr, :name_en, :slug, length: { minimum: 3, maximum: 30 }
  validates :description_short, :meta_description, length: { minimum: 50, maximum: 500 }
  validates :seo_title, length: { minimum: 5, maximum: 150 }
  validates :product_type, inclusion: { in: product_types.keys }
  validates :ht_price_cents, numericality: { greater_than_or_equal_to: 1 }
  validates :certificate_background, presence: true, if: :certificable?

  default_scope { i18n.friendly.in_order }
  scope :published, -> { where(published: true) }
  scope :in_order, -> { order(position: :asc) }
  scope :in_stock, -> { joins(:product_skus).where.not(product_skus: { quantity: 0 }) }
  scope :with_variant, lambda { |variant|
    includes(:variabilizations).where(variabilizations: { variant: variant })
  }
  scope :displayable, -> { in_stock.published.with_attached_images }

  def should_generate_new_friendly_id?
    name_fr_changed? || name_en_changed? || super
  end

  def ttc_price_cents
    ht_price_cents * (1 + tax_rate.fdiv(100))
  end

  def variants_by_category
    variants.group_by(&:category)
  end

  def certificable?
    personalized? || tree?
  end
end
