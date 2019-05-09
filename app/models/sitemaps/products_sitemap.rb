# frozen_string_literal: true

class ProductsSitemap < Sitemap
  def name
    'products.xml'
  end

  private

  def items
    Product.all
  end
end
