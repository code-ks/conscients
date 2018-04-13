# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
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
#

class Product < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
  has_many_attached :images

  extend Mobility
  translates :name, :description, :seo_title, :meta_description, :keywords, :slug

  include FriendlyId
  friendly_id :name, use: %i[slugged mobility]

  acts_as_list
  monetize :ht_price_cents, :ht_buying_price_cents, :ttc_price_cents

  enum product_type: { classic: 0, personalized: 1, tree: 2 }

  validates :name, :description, :ht_price_cents, :product_type, :published, :seo_title,
            :meta_description, :slug, :tax_rate, presence: true
  validates :name, :slug, :seo_title, uniqueness: true
  validates :name, :slug, length: { minimum: 3, maximum: 30 }
  validates :description, :meta_description, length: { minimum: 50, maximum: 500 }
  validates :seo_title, length: { minimum: 5, maximum: 150 }
  validates :product_type, inclusion: { in: product_types.keys }
  validates :ht_price_cents, numericality: { greater_than_or_equal_to: 1 }

  default_scope { i18n.friendly }
  scope :published, -> { where(published: true) }
  scope :in_order, -> { order(position: :asc) }
  scope :favorite, -> { where(favorite: true) }

  def should_generate_new_friendly_id?
    name_changed? || super
  end

  def ttc_price_cents
    ht_price_cents * (1 + tax_rate)
  end
end
