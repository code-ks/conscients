# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :set_product, :set_variant, :set_product_sku, only: %i[create update]
  before_action :set_line_item, only: %i[update destroy]

  respond_to :js, :html

  def create
    @line_item = AddItemToCart.new(@cart, line_item_params, quantity)
                              .perform
    respond_with(@line_item, location: product_path(@product)) do |format|
      format.html { render 'products/show' } unless @line_item.save
    end
  end

  def update
    flash[:alert] = 'Stock trop faible' unless @line_item.update(line_item_params_update)
    redirect_to cart_path(@cart)
  end

  def destroy
    @line_item.destroy
    redirect_back fallback_location: cart_path(@cart)
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def set_product
    @product = Product.with_attached_images.find(params[:product_id])
  end

  def set_variant
    @variant = params.dig(:variant, :id) ? Variant.find(params.dig(:variant, :id)) : nil
  end

  def set_product_sku
    @product_sku = @product.product_skus
                           .merge(@variant&.product_skus || @product.product_skus)
                           .first
  end

  def quantity
    params.dig(:line_item, :quantity)
  end

  def line_item_params
    params[:line_item] = { empty: true } unless params.key?(:line_item)
    params.require(:line_item).permit(:recipient_name, :recipient_message, :certificate_date)
          .merge(product_sku_id: @product_sku.id)
  end

  def line_item_params_update
    params.require(:line_item).permit(:recipient_name, :recipient_message,
                                      :certificate_date, :quantity)
          .merge(product_sku_id: @product_sku.id)
  end
end
