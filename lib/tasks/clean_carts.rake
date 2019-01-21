# frozen_string_literal: true

Rails.logger = Logger.new(STDOUT)

task clean_carts: :environment do
  Order.cart_to_destroy.each do |cart|
    cart.line_items.each do |line_item|
      line_item.product_sku.increment(:quantity, line_item.quantity) unless tree?
      line_item.tree_plantation.increment(:quantity, line_item.quantity) unless classic?
    end
    cart.destroy!
  end
end
