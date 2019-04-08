# frozen_string_literal: true

# Initialize complete line item object when added to cart for the first time or for update
# (quantity, tree_plantation, certificate_number)
# Be careful that the right tree_plantation is kept when line_item just updated (to check)
class AddItemToCart
  def initialize(cart, line_item_params, quantity)
    @cart = cart
    @line_item_params = line_item_params
    @quantity = quantity.to_i
  end

  def perform
    find_or_initialize_line_item
    add_attributes_certicable_line_item if @line_item.tree?
    update_quantity_line_item
    @line_item
  end

  private

  def find_or_initialize_line_item
    @line_item = @cart.line_items.find_or_initialize_by(@line_item_params)
  end

  def add_attributes_certicable_line_item
    set_tree_plantation
    add_plantation_attributes_to_line_item
  end

  # Quantity is 0 by default but could be more if line item already in cart (and just updated)
  def update_quantity_line_item
    @line_item.assign_attributes(quantity: @line_item.quantity + @quantity)
  end

  def set_tree_plantation
    @tree_plantation = TreePlantation.first_with_needed_quantity(@quantity)
  end

  def add_plantation_attributes_to_line_item
    @line_item.assign_attributes(tree_plantation: @tree_plantation,
                                 certificate_number: @tree_plantation.generate_certificate_number)
  end
end
