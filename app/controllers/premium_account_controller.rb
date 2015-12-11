class PremiumAccountController < ApplicationController
  before_action :premium_account_params, only: [:create]
  before_action :find_shop, only: [:create, :update]

  def create
    @shop.create_premium_account(premium_account_params)
    redirect_to :back, notice: "succesfully created"
  end

  def update
    @shop = Shop.find params[:premium_account][:shop_id]

    if params[:premium_account][:status]
      redirect_to :back, notice: "succesfully updated" if @shop.premium_account.update_attributes(premium_account_params)
    else
      @shop.premium_account.destroy
    end

    # if @shop.premium_account.update_attributes(premium_account_params)
    #   redirect_to :back, notice: "succesfully updated"
    # else
    #   qwer
    # end
  end

  private

    def find_shop
      @shop = Shop.find params[:premium_account][:shop_id]
    end

    def premium_account_params
      params.require(:premium_account).permit(:status, :url, :shop_id, :user_id)
    end

end
