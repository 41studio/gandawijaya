ready = ->
  $('.choice').hide()
  $('.btn-submit-review').prop("disabled", true)

  $(':radio').change ->
    $('#review_rate_point').val( this.value )
    if $('#review_content').val()
      $('.btn-submit-review').prop("disabled", false)

  $('#review_content').keyup ->
    if $(this).val() && $('#review_rate_point').val()
      $('.btn-submit-review').prop("disabled", false)
    else
      $('.btn-submit-review').prop("disabled", true)

  $("#radio_1").prop("checked", true)



  $("#radio_1").prop("checked", true)

$(document).ready ready
$(document).on "page:load", ready