# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_category, only: :index

  def index
    @products = if params[:category_id]
                  @category.products
                elsif params[:search]
                  Product.search_by_name(params[:search])
                else
                  Product.all
                end
    @products = @products.published.with_skus.with_attached_images
  end

  def show
    @product = Product.with_attached_images.find(params[:id])
  end

  private

  def set_category
    @category = params[:category_id] ? Category.find(params[:category_id]) : Category.home
  end
end
