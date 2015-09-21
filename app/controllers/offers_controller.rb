class OffersController < ApplicationController
before_action :offer_params, only: [:create]

  def create
    offer_room = OfferRoom.where(shop_id: params[:offer][:shop_id], product_id: params[:offer][:product_id])
                .first_or_create
    offer = offer_room.offers.new(offer_params)
    offer.user_id = current_user.id
    if offer.save!
      redirect_to :back, notice: "offer succesfully created"
    else
      redirect_to :back
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:content, :owner)
  end
end