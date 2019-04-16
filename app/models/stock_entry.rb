# frozen_string_literal: true

# == Schema Information
#
# Table name: stock_entries
#
#  id             :bigint(8)        not null, primary key
#  product_sku_id :bigint(8)
#  quantity       :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (product_sku_id => product_skus.id)
#

class StockEntry < ApplicationRecord
  belongs_to :product_sku

  after_create :update_stock_product_sku, only: :create

  def readonly?
    new_record? ? false : true
  end

  def update_stock_product_sku
    product_sku.quantity += quantity
    product_sku.save!
  end
end
