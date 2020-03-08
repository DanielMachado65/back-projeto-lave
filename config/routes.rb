Rails.application.routes.draw do
  resources :products
  resources :establishments
  resources :orders

  namespace :api do
    namespace :v1 do

      resources :users, only: %I[create destroy show update]
      resources :categories
      resources :addresses

      post '/login', to: 'sessions#login'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
