# frozen_string_literal: true

class IndexSitemap < Sitemap
  def build
    builder.to_xml
  end

  def name
    'index.xml'
  end

  private

  def builder
    Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.sitemapindex('xlmns' => 'http://www.sitemaps.org/schemas/sitemap/0.9') do
        urls.each do |url|
          xml.sitemap do
            xml.loc url
            xml.lastmod Time.zone.now.strftime('%F')
          end
        end
      end
    end
  end

  def filename
    name
  end

  def urls
    [
      CategoriesSitemap.new('fr').url,
      CategoriesSitemap.new('en').url,
      ProductsSitemap.new('fr').url,
      ProductsSitemap.new('en').url,
      StaticPagesSitemap.new('fr').url,
      StaticPagesSitemap.new('en').url
    ]
  end
end
