Rails.application.routes.draw do
  post 'login', to: 'users#show'
  post 'create', to: 'users#create'
end
