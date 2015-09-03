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
	
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: "users/registrations" }
  root 'pages#dashboard'
  resources :products do 
  	member do
  	 get "like", to: "products#upvote"
     get "dislike", to: "products#downvote"
    end
  end   
  resources :shops do 
  	member do 
  	 get "like", to: "shops#upvote"
     get "dislike", to: "shops#downvote"
    end
  end   	

  get '/prodiscc/:id', to: 'products#product_disccusion', as: :product_disccusion
  post '/comment_create', to: 'products#create_comment', as: :comment_create


 end
