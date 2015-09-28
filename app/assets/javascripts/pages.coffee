ready = ->
  $('.form-status').toggle()
  $('#btn-status-edit').click ->
    $('.form-status').toggle()
    $('.current-status').toggle()
    if $('.form-status').is(":hidden")
      $(this).text "change"
    else
      $(this).text "cancel"
  # $('#ajax-modal').on 'hidden.bs.modal', ->
  #   $('.js-all-user-offer').html("<%= j render partial: 'shared/modal_offer_user', collection: OfferRoom.first, as: 'room' %>")

$(document).ready ready
$(document).on "page:load", ready
