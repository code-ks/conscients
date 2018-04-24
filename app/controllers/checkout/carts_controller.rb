# frozen_string_literal: true

class Checkout::CartsController < ApplicationController
  def show
    redirect_to root_path unless @cart == Order.find(params[:id])
  end
end
