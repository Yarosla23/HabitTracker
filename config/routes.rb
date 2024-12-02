Rails.application.routes.draw do
  resources :habits
  get 'home/index'

  devise_for :users
    resources :users do
      resource :profile, only: %i[new create edit update destroy show] do
        get :connect_telegram, on: :collection
      end
    end


  root 'home#index'
end
