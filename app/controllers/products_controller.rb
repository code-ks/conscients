# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    if params[:category_id]
      @products = Category.find(params[:category_id]).products
    else
      @product = Product.all
    end
    @products = @products.published.with_attached_images
  end

  def show
    @product = Product.with_attached_images.find(params[:id])
  end
end
