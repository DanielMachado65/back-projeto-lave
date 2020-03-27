Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %I[create destroy show update]
      resources :categories
      resources :addresses
      resources :establishments
      resources :products, expect: :index

      # order
      resources :order_statuses, only: %I[index show create]
      resources :orders

      post '/login', to: 'sessions#login'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
