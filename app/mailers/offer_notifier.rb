class OfferNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_notifier.received.subject
  #
  # offer.offer_room.offers.length
  def received(offer)
    room  = offer.offer_room
    @product = room.product_name
    content = offer.content
    # if offer.offer_room.offers.length == 1
    #   @recipient_name = "room.product.shop_name"
    #   @opening_text = "Anda menerima penawaran untuk product"
    #   @closing_text = "Balas penawaran ini ke email penawar yang sudah di cantumkan diatas"
    # else
    #   @recipient_name = offer.user_id == room.user_id ? "room.product.shop_name" : "offer.user_first_name"
    #   @opening_text = "Anda menerima balasan untuk penawaran product"
    #   @closing_text = "Balas pesan ini ke email yang sudah di cantumkan diatas"
    # end

    if offer.offer_room.offers.length == 1
      @recipient_name = room.product.shop_name
      @opening_text = "Someone offer for your product"
    else
      # @recipient_name = offer.user_id == room.user_id ? room.product.shop_name : offer.user_first_name
      @recipient_name = offer.user_id == room.user_id ? room.product.shop_name : room.user_first_name
      # recipient = current_user.id == offer_room.user_id ? offer_room.shop_business_email : offer_room.user_email
      @opening_text = "You received a message for product's offer"
    end
    # @recipient_name = room.product.user
    @content = offer.content

    # @mail_content = [recipient_name: recipient_name, content: content, opening_text: opening_text, closing_text: closing_text]
    # byebug
    if room.user_id?
      email = offer.recipient
      @name  = room.user_first_name
      @phone =  room.user_handphone
      @email_recipient = offer.user_id == room.user_id ? offer.offer_room.user_email : offer.offer_room.shop_business_email
    else
      email = room.email
      @name = room.name
      @email_recipient = email
      @phone = room.telephone
    end
    mail to: email,
         from: 'services@gandawijaya.com',
         subject: "#{@product} Offer"
  end
end
