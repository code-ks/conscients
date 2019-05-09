# frozen_string_literal: true

class Sitemap
  def initialize(locale = nil)
    @locale = locale || 'fr'
  end

  def build
    builder.to_xml
  end

  def items
    raise NotImplementedError, 'You must implement #items'
  end

  def name
    raise NotImplementedError, 'You must implement #name'
  end

  def url
    "https://s3.eu-west-3.amazonaws.com/photo-conscients-bebe-bio/#{PREFIX}/#{@locale}/#{name}"
  end

  def save!
    Storage.new(PREFIX).create_file(filename, build)
  end

  private

  def builder
    Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
      xml.urlset(
        'xlmns' => 'http://www.sitemaps.org/schemas/sitemap/0.9',
        # "xmlns:xhtml" => "http://www.w3.org/1999/xhtml",
        'xmlns:xhtml' => 'default'
      ) do
        items.each do |item|
          xml.lastmod item.lastmod if item.lastmod
          xml.url do
            xml.loc("#{ROOT}#{item.url(@locale)}")
            I18n.available_locales.map(&:to_s).each do |loc|
              xml['xhtml'].link rel: 'alternate', hreflang: loc, href: "#{ROOT}#{item.url(loc)}"
            end
          end
        end
      end
    end
  end

  def filename
    "#{@locale}/#{name}"
  end

  ROOT = 'https://www.conscients.com'
  PREFIX = 'sitemaps'
end
