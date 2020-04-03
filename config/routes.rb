Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # users
      resources :users, only: %I[create destroy]
      post '/user/address', to: 'users#address'
      get '/user/orders', to: 'users#orders'
      put '/user', to: 'users#update'
      get '/user', to: 'users#show'

      resources :categories
      resources :addresses
      resources :products, expect: :index
      
      # establishment
      resources :establishment do
        get '/orders', to: 'establishments#orders'
      end 

      # order
      resources :order_statuses, only: %I[index show create]
      resources :orders, expect: :index do
        resources :order_lines, only: %I[create destroy]
      end

      post '/login', to: 'sessions#login'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
