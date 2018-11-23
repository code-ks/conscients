# frozen_string_literal: true

I18n.default_locale = :fr
I18n.available_locales = %i[en fr]
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
