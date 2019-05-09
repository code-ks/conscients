# frozen_string_literal: true

class SitemapTestsController < ApplicationController
  def index
    # render xml: CategoriesSitemap.new('fr').build
    # render xml: CategoriesSitemap.new('en').build
    # render xml: ProductsSitemap.new('fr').build
    # render xml: ProductsSitemap.new('en').build
    # render xml: StaticPagesSitemap.new('fr').build
    # render xml: StaticPagesSitemap.new('en').build
    render xml: IndexSitemap.new.build
  end
end
