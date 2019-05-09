# frozen_string_literal: true

class StaticPagesSitemap < Sitemap
  def name
    'static_pages_pages.xml'
  end

  private

  URLS = %w[
    about b2b contact
    faq participate payment_shipping
    sitemap terms
  ].freeze

  def items
    URLS.map do |url|
      StaticPage.new(url)
    end
  end

  class StaticPage
    def initialize(url)
      @url = url
    end

    def lastmod; end

    def url(locale = nil)
      suffix = "?locale=#{locale}" if locale && locale != 'fr'
      "/#{@url}#{suffix}"
    end
  end
end
