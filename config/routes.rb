Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # users
      resources :users, only: %I[create destroy]
      post '/users_address', to: 'users#address'
      put '/users', to: 'users#update'
      get '/users', to: 'users#show'

      resources :categories
      resources :addresses
      resources :establishments
      resources :products, expect: :index

      # order
      resources :order_statuses, only: %I[index show create]
      resources :order_lines, only: %I[create]
      resources :orders, expect: :index

      post '/login', to: 'sessions#login'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
