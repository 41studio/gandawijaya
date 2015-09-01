Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/registrations" }
  resources :products
  resources :shops

  root 'shops#index'
 end
