# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'pg', '>= 0.18'
gem 'puma', '~> 3.11'
gem 'rails', '5.2.2'

gem 'friendly_id-mobility', '~> 0.5'
# Content translation (like Globalize but much better) --> https://github.com/shioyama/mobility
gem 'mobility', '~> 0.5'
gem 'rails-i18n', '~> 5.1'

gem 'uglifier', '~> 4.1'
gem 'webpacker', '~> 3.4'

gem 'aws-sdk-s3', '~> 1.13', require: false
gem 'jbuilder', '~> 2.5'
gem 'mini_magick', '~> 4.8'
gem 'redis', '~> 4.0'

gem 'bootsnap', '~> 1.3', require: false
gem 'oj', '~> 3.5'
gem 'rollbar', '~> 2.15'

gem 'sidekiq', '~> 5.1'
gem 'sidekiq-failures', '~> 1.0'

# Analytics for rails --> https://github.com/ankane/ahoy
gem 'ahoy_matey', '~> 2.0'
gem 'devise', '~> 4.4'
gem 'devise-i18n', '~> 1.6'
gem 'devise_invitable', '~> 1.7', '>= 1.7.5'
gem 'gibbon', '~> 3.2'
gem 'omniauth-facebook', '~> 5.0'
gem 'postmark-rails', '~> 0.16'

gem 'activeadmin', '~> 1.4'
# Thème for activeadmin
gem 'arctic_admin', '~> 1.4'
# Search for active admin
gem 'ransack', '~> 2.1', '>= 2.1.1'

gem 'acts_as_list', '~> 0.9'
# Tree structure for models (categories in our case) --> https://github.com/stefankroes/ancestry
gem 'ancestry', '~> 3.0'
gem 'friendly_id', '~> 5.2'
# Static pages
gem 'high_voltage', '~> 3.0'
gem 'meta-tags', '~> 2.9'
# Clean respond with in controllers
gem 'responders', '~> 2.4'

gem 'aasm', '~> 4.12'
gem 'money-rails', '~> 1.11'
gem 'paypal-sdk-rest', '~> 1.7'
gem 'stripe', '~> 3.13'

gem 'kaminari', '~> 1.2'
gem 'pg_search', '~> 2.1'
gem 'wicked_pdf', '~> 1.1'
gem 'wkhtmltopdf-binary', '~> 0.12'
gem 'wkhtmltopdf-heroku', '~> 2.12', '>= 2.12.4.0'

gem 'country_select', '~> 3.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.4'
gem 'sass-rails', '~> 5.0'

gem 'invisible_captcha'

# debugging
gem 'pgsync' # Sync Postgres data between databases (ex: from Production To Development)
gem 'pretender' # login as any user

group :development, :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'pry-byebug', '~> 3.6'
  gem 'pry-rails', '~> 0.3'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  # gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'letter_opener', '~> 1.6'
  # Find back messages sent to letter_opener in a web interface
  gem 'letter_opener_web', '~> 1.3'

  gem 'listen', '~> 3.1'
  gem 'spring', '~> 2.0'
  gem 'spring-watcher-listen', '~> 2.0'

  gem 'annotate', '~> 2.7'
  gem 'awesome_print', '~> 1.8'
  # Possible to desactivate alerts if too annoying
  gem 'bullet', '~> 5.7'
  # Generate schéma of database automatically in erd.pdf
  gem 'rails-erd', '~> 1.5'
  gem 'table_print', '~> 1.5'
  gem 'xray-rails', '~> 0.3'

  gem 'brakeman', '~> 4.2', require: false
  gem 'overcommit', '~> 0.44'
  # gem 'rubocop', '~> 0.71', require: false
  gem 'rubocop-rails', require: false

  gem 'guard', '~> 2.14'
  gem 'guard-bundler', '~> 2.1', require: false
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload', '~> 0.3'

  gem 'better_errors', '~> 2.4'
  gem 'binding_of_caller', '~> 0.8'
  gem 'web-console', '~> 3.6'
end
