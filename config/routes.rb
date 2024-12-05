Rails.application.routes.draw do
  get 'home/index'
  get '/auth/:provider/callback', to: 'users/omniauth_callbacks#telegram'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks' 
  }
  
  resources :habits do
    member do
      patch :complete
    end
  end

  resources :users, only: [] do
    resource :profile, only: %i[new create edit update destroy show] do
      get :connect_telegram, on: :collection
    end
  end

  root 'home#index'
end
