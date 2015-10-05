class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def dashboard
    @shops = Shop.order(created_at: :desc)
    @products = Product.order(created_at: :desc)
  end

  def profile
    @user_products = current_user.products
    @user_shops = current_user.shops
    @offer_rooms = current_user.offer_rooms.newest
  end

  def collect_offers
    @product = Product.find params[:product]
    @offers = @product.offer_rooms.where(user_id: params[:user_id]).first.try(:offers)
    if @offers
      if params[:user_id].to_i.eql? current_user.id
        @offers.each{ |o| o.update_attribute :read_by_offerer, true }
      else
        @offers.each{ |o| o.update_attribute :read_by_owner, true }
      end
    end
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
