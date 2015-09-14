ready = ->
  $('.choice').hide()
  $(':radio').change ->
    $('#review_rate_point').val( this.value )

  $("#radio_1").prop("checked", true)

$(document).ready ready
$(document).on "page:load", ready