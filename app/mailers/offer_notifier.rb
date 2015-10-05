class OfferNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_notifier.received.subject
  #
  def received(offer)
    @content = offer.content
    room  = offer.offer_room
    email_sender = room.user_id? ?  room.user.email : room.offerer
    mail to: room.product.user.email,
         from: 'services@gandawijaya.com',
         subject: "Offer for yur product | #{offer.offer_room.product.name}"

  end
end
