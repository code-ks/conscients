# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  devise_for :clients, only: :omniauth_callbacks,
  controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }

  scope '(:locale)', locale: /en/ do
    root to: 'pages#home'
    devise_for :clients, skip: :omniauth_callbacks,
               controllers: { registrations: 'clients/registrations' }

    # Blog posts are not managed in the normal Active Admin interface
    # because of the specific rich text editors
    namespace :admin do
      resources :blog_posts
    end
    resources :blog_posts, only: %i[index show]
    resources :contacts, only: :create
    resources :newsletter_subscriptions, only: :create
    resource :clients, only: :show
    resources :categories, only: [] do
      resources :products, only: :index
    end
    resources :products, only: :show do
      resources :line_items, only: %i[create update destroy]
    end
    resource :invoices, only: [] do
      scope module: :invoices do
        resources :downloads, only: :new
      end
    end
    resource :certificates, only: [] do
      scope module: :certificates do
        resources :downloads, only: :new
      end
    end
    resource :klm_files, only: [] do
      scope module: :klm_files do
        resources :downloads, only: :new
      end
    end
    # Routes for the checkout process --> Cart leads to deliveries choice leads to payments
    scope module: :checkout do
      resources :carts, only: :show
      resources :deliveries, only: %i[new create]
      resources :payments, only: %i[new show] do
        collection do
          post 'create_stripe'
          post 'create_paypal'
          post 'create_bank_transfer'
          get 'paypal_success'
        end
      end
      resources :coupon_to_order_additions, only: :create
    end
  end
end
