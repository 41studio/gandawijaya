ready = ->
  $('.choice').hide()
  $(':radio').change ->
    $('#review_rate_point').val( this.value )

$(document).ready ready
$(document).on "page:load", ready