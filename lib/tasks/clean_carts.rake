# frozen_string_literal: true

# Implemented with heroku scheduler --> destroy all cart_to_destroy
# (initially cart more than 2 days old)
# (currently cart more than 1 hour old)
# and reincrement the line_items and tree_plantations
Rails.logger = Logger.new(STDOUT)

task clean_carts: :environment do
  Order.cart_to_destroy.each do |cart|
    cart.line_items.each do |line_item|
      line_item.product_sku.increment(:quantity, line_item.quantity) unless line_item.tree?
      line_item.tree_plantation&.increment(:quantity, line_item.quantity)
    end
    cart.destroy!
  end
end
