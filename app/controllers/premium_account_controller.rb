class PremiumAccountController < ApplicationController
  # def create
  #   @shop = Shop.find params[:id]
  #   current_user.premium_shop_requests.create(approved: false, shop_id: @shop.id)
  #   redirect_to :back
  # end
  before_action :premium_account_params, only: [:create]

  def create
    shop = Shop.find params[:premium_account][:shop_id]
    shop.premium_account.update_attributes(premium_account_params)
    redirect_to :back, notice: "succesfully updated"
  end

  def premium_account_params
    params.require(:premium_account).permit(:status, :url, :shop_id, :user_id)
  end
end
