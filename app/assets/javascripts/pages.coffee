ready = ->
  $('.form-status').toggle()
  $('#btn-status-edit').click ->
    $('.form-status').toggle()
    $('.current-status').toggle()
    if $('.form-status').is(":hidden")
      $(this).text "change"
    else
      $(this).text "cancel"

$(document).ready ready
$(document).on "page:load", ready
