Rails.application.routes.draw do
  root to: 'home#index'

  resources :sessions
  resources :users
end
