# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  scope '(:locale)', locale: /en/ do
    root to: 'pages#home'

    devise_for :clients

    resources :categories, only: [] do
      resources :products, only: :index
    end
    resources :products, only: :show, shallow: true do
      resources :line_items, only: %i[create destroy]
    end
    scope module: :checkout do
      resources :carts, only: :show
    end
    get ':id', to: 'high_voltage/pages#show', as: :page, format: false
  end
end
