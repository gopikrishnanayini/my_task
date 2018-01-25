Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  root 'customers#index'
  resources :users
  resources :customers
end
