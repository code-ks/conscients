
require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'update_price' do
    it 'handles VAT rounding with quantities > 1' do
      product = FactoryBot.create(:product, ht_price_cents: 417)
      product_sku = FactoryBot.create(:product_sku, product: product, quantity: 100)
      order = FactoryBot.create(:order)
      line_item = FactoryBot.create(:line_item,
                                      quantity: 10,
                                      product_sku: product_sku,
                                      order: order)
      expect(line_item.ttc_price_cents).to eq 5000
    end
  end
end
