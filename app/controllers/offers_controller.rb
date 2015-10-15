class OffersController < ApplicationController
before_action :offer_params, only: [:create]

  def create
    offer_room = OfferRoom.find_if_any_or_initialize_by(params[:offer])

    if user_signed_in?
      offer         = offer_room.offers.new(offer_params)
      offer.user_id = current_user.id

      @offers       = offer_room.offers
      @offer_rooms  = OfferRoom.where(user_id: params[:offer][:user_id]).newest

      end
      if offer_room.save!
        respond_to do |format|
          format.html{ redirect_to :back, notice: "Offer succesfully created" }
          format.js
        end
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:content)
  end
end