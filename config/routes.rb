Rails.application.routes.draw do
  root to: 'home#index'

  resource :sessions
  resources :users
  resources :accounts
  resource :transfers
  resource :pay, controller: 'pay'
  resources :messages
  resource :pin, controller: 'pin', only: [:edit, :update]
end
