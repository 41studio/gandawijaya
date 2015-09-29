class OffersController < ApplicationController
before_action :offer_params, only: [:create]

  def create
    unless user_signed_in?
      params[:offer][:offerer] = params[:email_offerer]
    end

    params[:offer][:offerer] = current_user.id unless params[:offer][:offerer].present?
    offer_room = OfferRoom.where(shop_id:    params[:offer][:shop_id],
                                 product_id: params[:offer][:product_id],
                                 offerer:    params[:offer][:offerer]
                                 ).first_or_create
    offer = offer_room.offers.new(offer_params)

    if user_signed_in?
      offer.user_id = current_user.id
      @offers = offer.offer_room.offers
      @offer_rooms = OfferRoom.where(offerer: current_user.id).order(:created_at).reverse
    end

    if offer.save!
      respond_to do |format|
        format.html{ redirect_to :back, notice: "offer succesfully created" }
        format.js
      end
    end
  end

  def show
    @offerer = User.find params[:user_id]
    @product = Product.find params[:product_id]
    @offers = @product.offer_rooms.where(product: @product.id, offerer: @offerer.id).first.offers
  end

  private

  def offer_params
    params.require(:offer).permit(:content)
  end
end