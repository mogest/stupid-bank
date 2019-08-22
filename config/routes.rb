Rails.application.routes.draw do
  root to: 'home#index'

  resource :sessions
  resources :users
  resources :accounts
  resource :transfers
  resource :pay, controller: 'pay'
end
