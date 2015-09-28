class OfferNotifier < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.offer_notifier.received.subject
  #
  def received(offer)
    @content = offer.content
    mail to: offer.offer_room.product.user.email,
         from: offer.offer_room.offerer,
         subject: "Offer for yur product | #{offer.offer_room.product.name}"

  end
end
