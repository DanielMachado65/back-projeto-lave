Rails.application.routes.draw do
  resources :orders

  namespace :api do
    namespace :v1 do

      resources :users, only: %I[create destroy show update]
      resources :categories
      resources :addresses
      resources :establishments
      resources :products, expect: :index

      post '/login', to: 'sessions#login'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
