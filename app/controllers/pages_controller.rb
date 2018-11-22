# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @categories = Category.in_order_home.displayable
  end
end
