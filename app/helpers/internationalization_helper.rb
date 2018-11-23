# frozen_string_literal: true

module InternationalizationHelper
  def locale_links
    content = ''
    I18n.available_locales.each_with_index do |locale, i|
      content += '  |  ' unless i.zero?
      content += link_to locale.to_s, root_path(locale: correct_locale(locale))
    end
    content.html_safe
  end

  def correct_locale(locale)
    return if locale == I18n.default_locale

    locale
  end
end
