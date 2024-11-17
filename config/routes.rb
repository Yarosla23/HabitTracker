Rails.application.routes.draw do
  resources :habits
  get 'home/index'
  devise_for :users

  resource :profile, only: %i[show edit update]

  root 'home#index'
end
