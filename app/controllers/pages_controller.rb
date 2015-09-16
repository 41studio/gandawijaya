class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def dashboard
    @shops = Shop.order(created_at: :desc)
    @products = Product.order(created_at: :desc)
  end

  def profile
    @user_products = current_user.products
    @user_shops = current_user.shops
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
