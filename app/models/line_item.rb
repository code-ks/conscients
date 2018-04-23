# frozen_string_literal: true

# == Schema Information
#
# Table name: line_items
#
#  id                 :integer          not null, primary key
#  product_sku_id     :integer
#  order_id           :integer
#  tree_plantation_id :integer
#  quantity           :integer          default(0), not null
#  recipient_name     :string
#  recipient_message  :text
#  certificate_date   :date
#  certificate_number :string
#  delivery_email     :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_sku_id => product_skus.id)
#  fk_rails_...  (tree_plantation_id => tree_plantations.id)
#

class LineItem < ApplicationRecord
  belongs_to :product_sku, autosave: true
  belongs_to :order
  belongs_to :tree_plantation, optional: true, autosave: true

  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :recipient_message, length: { maximum: 300 }
  # validates :recipient_name, :certificate_date, :certificate_number,
  #           presence: true, if: :certificable?

  before_validation :decrement_stock_quantities, prepend: true

  delegate :certificable?, to: :product_sku
  delegate :classic?, to: :product_sku
  delegate :personnalized?, to: :product_sku
  delegate :tree?, to: :product_sku
  delegate :product_images, to: :product_sku

  def added_quantity
    quantity - quantity_was
  end

  private

  def decrement_stock_quantities
    product_sku.decrement(:quantity, added_quantity) unless tree?
    tree_plantation.decrement(:quantity, added_quantity) unless classic?
  end
end
