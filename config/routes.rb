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

  root 'pages#dashboard'
  put '/avatarchange', to: 'pages#change_avatar', as: :change_avatar
  get '/myprofile', to: "pages#profile", as: :profile_pages
  get '/collect_offers', to: "pages#collect_offers"

  post '/reviews/create', to: 'review#create', as: "reviews"

  put "/likeproduct/:id", to: "products#like", as: :like_product
  put "/likeshop/:id", to: "shops#like", as: :like_shop

  # buat routes yang mengarah pada fungsi approve dan reject
  post 'shop/approve', to: "shops#approve", as: "approve"
  delete 'shop/reject', to: "shops#reject", as: "reject"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :shops do
    resources :products
    get 'controlpanel', on: :member
  end
  get '/:shop_id/controlpanel/offer/:product_id/:user_id', to: "offers#show", as: :show_offers
  devise_for :users, controllers: { sessions: "users/sessions",
                                    registrations: "users/registrations",
                                    omniauth_callbacks: "users/omniauth_callbacks" }

  post '/premium/request/:id', to: "premium_account#create"
  patch '/premium/request/:id', to: "premium_account#update"
  get '/:premium_path/edit',to: "shops#edit", as: :edit_shop_premium
  get '/:premium_path',to: "shops#show", as: :shop_premium
  get '/:premium_path/controlpanel', to: "shops#controlpanel", as: :controlpanel_shop_premium
  get '/:premium_path/controlpanel/offer/:product_id/:user_id', to: "offers#show", as: :show_offers_premium
  put '/:premium_path',to: "shops#update", as: :update_shop_premium
  scope '/:premium_path' do
    resources :products, as: :product_premium
  end
  get '/prodiscc/:id', to: 'products#product_disccusion', as: :product_disccusion
  post '/comment_create', to: 'products#create_comment', as: :comment_create
  get 'search', to: 'pages#dashboard'
  patch 'user/status/update', to: "pages#change_status", as: :change_status_user
  get "/shop/autocompletecategory", to: "shops#autocompletecategory"
  resources :offers, only: [:create]
 end

