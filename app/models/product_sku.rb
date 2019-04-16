# frozen_string_literal: true

# == Schema Information
#
# Table name: product_skus
#
#  id         :bigint(8)        not null, primary key
#  product_id :bigint(8)
#  variant_id :bigint(8)
#  sku        :string           not null
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (variant_id => variants.id)
#

class ProductSku < ApplicationRecord
  belongs_to :product
  belongs_to :variant, optional: true
  has_many :stock_entries, dependent: :nullify
  has_many :line_items, dependent: :nullify
  has_many :orders, through: :line_items

  before_validation :normalize_sku, only: :create
  before_update :alert_on_zero_quantity

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sku, presence: true, uniqueness: true, length: { minimum: 3 }

  delegate :name, :images, :ttc_price_cents, :ht_price_cents, :weight, to: :product, prefix: true
  delegate :classic?, :personalized?, :tree?, :certificate_background,
           :producer_latitude, :producer_longitude, to: :product
  delegate :color_certificate, to: :product, allow_nil: true

  default_scope { includes(:product, :variant) }
  scope :in_stock, -> { where('quantity > ?', 0) }

  def to_s
    variant ? "#{product_name} / #{variant.value}" : product_name
  end

  def normalize_sku
    self.sku = SecureRandom.uuid
  end

  # rubocop:disable Metrics/AbcSize
  def alert_on_zero_quantity
    return unless quantity != quantity_was && quantity_was.positive? && quantity.zero?

    ContactMailer.with(
      subject: "Stock alert SKU: #{sku} - product: #{product.name}",
      message: "The quantity reached 0 for the product #{product.name} with the sku #{sku}"
    ).stock_alert.deliver_later
  end
  # rubocop:enable Metrics/AbcSize
end
