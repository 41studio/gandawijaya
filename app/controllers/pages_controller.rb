class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def dashboard
    @shops    = Shop.newest
    @products = Product.includes(:shop).newest
  end

  def profile
    @user_products = current_user.products.newest
    @user_shops    = current_user.shops.newest
    @offer_rooms   = current_user.offer_rooms.newest
  end

  def collect_offers
    @product = Product.includes(:offers).find params[:product_id]
    @offers  = @product.offers.where(user_id: params[:user_id])
    read_sym = params[:user_id].to_i.eql?(current_user.id) ? :read_by_offerer : :read_by_owner
    @offers.update_all(read_sym => true)
  end

  def change_avatar
    if params[:image].present?
      current_user.image =  params[:image]
      current_user.save
    end
      redirect_to :back
  end

  def change_status
    if params[:user][:status].present?
      current_user.update_attribute :status, params[:user][:status]
    end
    redirect_to :back
  end
end
