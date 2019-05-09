# frozen_string_literal: true

namespace :sitemap do
  desc 'Generate all sitemaps'
  task generate_all: :environment do
    CategoriesSitemap.new('fr').save!
    CategoriesSitemap.new('en').save!
    ProductsSitemap.new('fr').save!
    ProductsSitemap.new('en').save!
    StaticPagesSitemap.new('fr').save!
    StaticPagesSitemap.new('en').save!
    IndexSitemap.new.save!
  end
end
