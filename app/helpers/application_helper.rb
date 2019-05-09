# frozen_string_literal: true

module ApplicationHelper
  def hreflang_default_url
    r = request.fullpath
    a = action_name
    c = controller_name

    return r.remove('?locale=en') if r.include?('?locale=en')

    if c == 'products'
      return @product.url           if a == 'show'
      return @current_category.url  if a == 'index'
    end

    url_for(locale: :fr).remove('/fr')
  end
end
