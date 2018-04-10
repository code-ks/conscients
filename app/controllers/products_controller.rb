# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.published.order_for_display.with_attached_image
  end

  def show; end
end
