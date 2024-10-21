# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'stock_prices/price_all', to: 'stock_prices#price_all'
      resources :wallets
      resources :transactions, only: [:create]
      post 'login', to: 'sessions#create'
    end
  end
end
