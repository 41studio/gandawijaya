class OfferNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_notifier.received.subject
  #
  def received(offer)
    @content = offer.content
    room  = offer.offer_room
    @product = room.product.name
    @owner = room.product.user
    if room.user_id?
      owner  = room.user
      @email = owner.email
      @name  = owner.username
      @phone =  owner.handphone
    else
      owner = room.offerer.split('|')
      @email = owner.first
      @name = owner.second
      @phone = owner.third
    end
    mail to: @email,
         from: 'services@gandawijaya.com',
         subject: "#{@product} Offer"
  end
end
