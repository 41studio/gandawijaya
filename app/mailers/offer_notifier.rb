class OfferNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_notifier.received.subject
  #
  def received(offer)
    @content = offer.content
    room  = offer.offer_room
    @product = room.product_name
    @owner = room.product.user

    if room.user_id?
      @email = offer.recipient
      @name  = room.user_username
      @phone =  room.user_handphone
    else
      @email = room.email
      @name = room.name
      @phone = room.telephone
    end
    mail to: @email,
         from: 'services@gandawijaya.com',
         subject: "#{@product} Offer"
  end
end
