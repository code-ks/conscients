# frozen_string_literal: true

# == Schema Information
#
# Table name: product_skus
#
#  id         :integer          not null, primary key
#  product_id :integer
#  sku        :string           not null
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#

class ProductSku < ApplicationRecord
  belongs_to :product
  has_many :variabilizations, dependent: :destroy
  has_many :variants, through: :variabilizations
  has_many :stock_entries, dependent: :destroy
  has_many :line_items, dependent: :nullify
  has_many :orders, through: :line_items

  before_validation :normalize_sku, only: :create

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :sku, presence: true, uniqueness: true, length: { minimum: 3 }

  delegate :name, to: :product, prefix: true
  delegate :certificable?, to: :product
  delegate :classic?, to: :product
  delegate :personnalized?, to: :product
  delegate :tree?, to: :product

  default_scope { includes(:product, :variabilizations, :variants) }
  scope :with_variant, lambda { |variant|
    includes(:variabilizations).where(variabilizations: { variant: variant })
  }
  scope :in_stock, -> { where('quantity > ?', 0) }

  def to_s
    string = product_name.to_s
    variants.each { |variant| string += " / #{variant.category.capitalize} #{variant.value}" }
    string
  end

  def age
    variants.age.first
  end

  def normalize_sku
    self.sku = SecureRandom.uuid
  end
end
