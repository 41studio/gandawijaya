class PremiumRequestController < ApplicationController
  def create
    @shop = Shop.find params[:id]
    current_user.premium_shop_requests.create(approved: false, shop_id: @shop.id)
    redirect_to :back
  end
end
