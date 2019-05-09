# frozen_string_literal: true

class CategoriesSitemap < Sitemap
  def name
    'categories.xml'
  end

  private

  def items
    Category.all
  end
end
