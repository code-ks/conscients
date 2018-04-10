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
#  taxe_rate                :decimal(4, 2)    default(20.0)
#  weight                   :integer          default(0)
#  product_type             :integer          default("classic")
#  published                :boolean          default(TRUE)
#  display_order            :integer
#  ht_buying_price_cents    :integer          default(0), not null
#  ht_buying_price_currency :string           default("EUR"), not null
#  seo_title                :string
#  meta_description         :string
#  keywords                 :text             default([]), is an Array
#  url                      :string
#  producer_latitude        :decimal(11, 8)
#  producer_longitude       :decimal(11, 8)
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Product < ApplicationRecord
  has_one_attached :image

  enum product_type: { classic: 0, personalized: 1, tree: 2 }
  validates :name, :description, :seo_title, :meta_description, :url, :image, presence: true
  validates :name, :url, length: { minimum: 5, maximum: 30 }
  validates :description, :meta_description, length: { minimum: 100, maximum: 500 }
  validates :seo_title, length: { minimum: 10, maximum: 150 }
  validates :product_type, inclusion: { in: product_types.keys }
  validates :ht_price_cents, :ht_buying_price_cents, numericality: { greater_than_or_equal_to: 1 }

  scope :published, -> { where(published: true) }
  scope :order_for_display, -> { order(display_order: :asc) }

  def ttc_price_cents
    ht_price_cents * (1 + taxe_rate)
  end
end
