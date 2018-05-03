# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope '/(:locale)', locale: /ru|en/ do
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :clients, only: :omniauth_callbacks,
                       controllers: { omniauth_callbacks: 'clients/omniauth_callbacks' }

  scope '(:locale)', locale: /en/ do
    root to: 'pages#home'

    devise_for :clients, skip: :omniauth_callbacks

    resources :categories, only: [] do
      resources :products, only: :index
    end
    resources :products, only: :show, shallow: true do
      resources :line_items, only: %i[create destroy]
    end
    scope module: :checkout do
      resources :carts, only: :show
      resources :deliveries, only: %i[new create]
      resources :paiements, only: :new
      resources :coupon_to_order_additions, only: :create
    end
    get ':id', to: 'high_voltage/pages#show', as: :page, format: false
  end
end
