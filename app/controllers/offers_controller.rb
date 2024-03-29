class OffersController < ApplicationController
before_action :offer_params, only: [:create]

  def create
    # byebug
    # unless user_signed_in?
    #   params[:offer][:offerer] = params[:email_offerer]+'|'+params[:name]+'|'+params[:phone]
    # else
    #   params[:offer][:user_id] = current_user.id unless params[:offer][:user_id].present?
    # end
    # offer_room = OfferRoom.where(shop_id:     params[:offer][:shop_id],
    #                               product_id: params[:offer][:product_id],
    #                               user_id:    params[:offer][:user_id]
    #                               ).first_or_create{ |offer| offer.offerer = params[:offer][:offerer] }
    # offer = offer_room.offers.new(offer_params)

    # if user_signed_in?
    #   offer.user_id = current_user.id
    #   @offers = offer.offer_room.offers
    #   @offer_rooms = OfferRoom.where(user_id: params[:offer][:user_id]).newest
    # end

    # if user_signed_in?
    #   params[:offer][:user_id] = current_user.id unless params[:offer][:user_id].present?
    # else
    #   params[:offer][:offerer] = params[:email_offerer]+'|'+params[:name]+'|'+params[:phone]
    # end
    puts "===================================params[:offer][:user_id]==================================="
    product = Product.find(params[:offer][:product_id])
    shop = Shop.find(product.shop_id)
    puts product.inspect
    puts shop.inspect

    offer_room = params[:offer][:offer_room_id].present? ? OfferRoom.find(params[:offer][:offer_room_id]) : OfferRoom.find_if_any_or_initialize_by(params[:offer], current_user.id, shop, product)
    puts offer_room.inspect
    # offer = offer_room.offers.new(offer_params)
    recipient = current_user.id == offer_room.user_id ? offer_room.shop_business_email : offer_room.user_email
    @type_req = current_user.id == offer_room.user_id ? "offerer" : "offer"
    puts "=============================================================@type_req"
    puts current_user.id
    puts offer_room.id
    puts @type_req

    if user_signed_in?
      offer = offer_room.offers.new(offer_params)
      offer.user_id = current_user.id
      offer.recipient = recipient
      @offers = offer_room.offers
      @offer_rooms = current_user.id == offer_room.user_id ? OfferRoom.where(user_id: current_user.id).newest : OfferRoom.where(user_id: offer_room.user_id).newest
    end

    if offer_room.save!
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