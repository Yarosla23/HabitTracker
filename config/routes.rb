Rails.application.routes.draw do
  resources :habits
  get 'home/index'
  devise_for :users

  root "home#index"
  resource :profile

end
