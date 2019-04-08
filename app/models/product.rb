# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                       :bigint(8)        not null, primary key
#  description_short        :string
#  description_long         :text
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
#  position_home            :integer
#  color_certificate        :string
#

class Product < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many :product_skus, dependent: :destroy
  has_many :line_items, through: :product_skus
  has_many :orders, through: :line_items
  has_many :variants, through: :product_skus
  has_many :coupons, dependent: :destroy
  has_many_attached :images
  has_one_attached :background_image
  has_one_attached :certificate_background

  extend Mobility
  # Change backend to allow query in translatable columns
  translates :name, backend: :column
  translates :description_short, :description_long, :seo_title, :meta_description,
             :keywords, :slug

  include FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  include PgSearch
  pg_search_scope :search_by_name,
                  against: %i[name_fr name_en],
                  using: { tsearch: { prefix: true } }

  acts_as_list
  acts_as_list column: :position_home
  monetize :ht_price_cents, :ht_buying_price_cents, :ttc_price_cents

  enum product_type: { classic: 0, personalized: 1, tree: 2 }

  validates :name_fr, :name_en, :description_short, :ht_price_cents, :product_type,
            :published, :seo_title, :meta_description, :slug, :tax_rate, presence: true
  validates :name_fr, :name_en, :slug, :seo_title, uniqueness: true
  validates :description_short, :meta_description, length: { minimum: 50, maximum: 500 }
  validates :seo_title, length: { minimum: 5, maximum: 150 }
  validates :product_type, inclusion: { in: product_types.keys }
  validates :ht_price_cents, numericality: { greater_than_or_equal_to: 1 }
  validates :certificate_background, presence: true, if: :tree?
  validates :color_certificate, presence: true,
                                format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/ },
                                if: :tree?
  validates :background_image, presence: true

  default_scope { i18n.friendly.in_order }
  scope :published, -> { where(published: true) }
  scope :in_order, -> { order(position: :asc) }
  scope :in_order_home, -> { order(position_home: :asc) }
  scope :images_attached, -> { joins(:images_attachments) }
  scope :in_stock, -> { joins(:product_skus).where.not(product_skus: { quantity: 0 }) }
  scope :with_variant, lambda { |variant|
    includes(:product_skus).where(product_skus: { variant: variant })
  }
  scope :displayable, -> { in_stock.published.joins(:images_attachments).images_attached }
  scope :home_displayable, -> { displayable.in_order_home }

  def should_generate_new_friendly_id?
    name_fr_changed? || name_en_changed? || super
  end

  def ttc_price_cents
    ht_price_cents * (1 + tax_rate.fdiv(100))
  end

  # Only age category for the moment. More categories would mean refactoring
  # quite a lot of things (we tried but there was a problem I don't remember)
  def variants_by_category
    variants.group_by(&:category)
  end
end
