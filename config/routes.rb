Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users, only: %I[create destroy show update]

      post '/login', to: 'sessions#login'
      post '/logout', to: 'sessions#destroy'
    end
  end
end
