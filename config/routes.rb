# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :clients, only: :omniauth_callbacks,
  controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }

  scope '(:locale)', locale: /en/ do
    devise_for :clients, skip: :omniauth_callbacks

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
