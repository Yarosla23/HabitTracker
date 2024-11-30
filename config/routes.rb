Rails.application.routes.draw do
  resources :habits
  get 'home/index'
  devise_for :users

  resource :profile, only: %i[show edit update] do
    get :connect_telegram, on: :collection
  end
  
  root 'home#index'
end
