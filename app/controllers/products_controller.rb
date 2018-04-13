# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.published.in_order.with_attached_images
  end

  def show
    @product = Product.with_attached_images.find(params[:id])
  end
end
