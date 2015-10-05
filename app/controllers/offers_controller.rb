class OffersController < ApplicationController
before_action :offer_params, only: [:create]

  def create
    unless user_signed_in?
      params[:offer][:offerer] = params[:email_offerer]
    else
      params[:offer][:user_id] = current_user.id unless params[:offer][:user_id].present?
    end
    offer_room = OfferRoom.where(shop_id:     params[:offer][:shop_id],
                                  product_id: params[:offer][:product_id],
                                  user_id:    params[:offer][:user_id]
                                  ).first_or_create{ |offer| offer.offerer = params[:offer][:offerer] }
    offer = offer_room.offers.new(offer_params)

    if user_signed_in?
      offer.user_id = current_user.id
      @offers = offer.offer_room.offers
      @offer_rooms = OfferRoom.where(user_id: params[:offer][:user_id]).newest
    end

    if offer.save!
      respond_to do |format|
        format.html{ redirect_to :back, notice: "offer succesfully created" }
        format.js
      end
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:content)
  end
end