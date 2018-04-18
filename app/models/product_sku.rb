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

  before_validation :normalize_sku, only: :create

  validates :quantity, presence: true
  validates :sku, presence: true, uniqueness: true, length: { minimum: 3 }

  delegate :name, to: :product, prefix: true

  def normalize_sku
    self.sku = SecureRandom.uuid
  end
end
