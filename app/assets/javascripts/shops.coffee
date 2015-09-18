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

  $('.add_fields').click ->
    partial = $('.nested').eq(-1)
    partial_selects = partial.find('select')

    partial.addClass("col-md-3")

    $("<span />", { text: $(partial_selects[0]).find("option:selected").text(), class: "day-work"  }).insertAfter(partial_selects[0]);

    open  = $(partial_selects[1]).find("option:selected").text()
    close = $(partial_selects[2]).find("option:selected").text()

    $("<span />", { text: open, class: "open-hour"  }).insertAfter(partial_selects[1]);
    $("<span />", { text: close }).insertAfter(partial_selects[2]);

    partial.find('select').hide()
    partial.find('label').hide()

$(document).ready ready
$(document).on "page:load", ready