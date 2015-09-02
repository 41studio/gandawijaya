# == Route Map
#
#       Prefix Verb   URI Pattern                  Controller#Action
#     products GET    /products(.:format)          products#index
#              POST   /products(.:format)          products#create
#  new_product GET    /products/new(.:format)      products#new
# edit_product GET    /products/:id/edit(.:format) products#edit
#      product GET    /products/:id(.:format)      products#show
#              PATCH  /products/:id(.:format)      products#update
#              PUT    /products/:id(.:format)      products#update
#              DELETE /products/:id(.:format)      products#destroy
#        shops GET    /shops(.:format)             shops#index
#              POST   /shops(.:format)             shops#create
#     new_shop GET    /shops/new(.:format)         shops#new
#    edit_shop GET    /shops/:id/edit(.:format)    shops#edit
#         shop GET    /shops/:id(.:format)         shops#show
#              PATCH  /shops/:id(.:format)         shops#update
#              PUT    /shops/:id(.:format)         shops#update
#              DELETE /shops/:id(.:format)         shops#destroy
#

Rails.application.routes.draw do

  post '/reviews/create', to: 'review#create', as: "reviews"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'pages#dashboard'
  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations",
                                    omniauth_callbacks: "users/omniauth_callbacks" }
  resources :products
  resources :shops


 end
