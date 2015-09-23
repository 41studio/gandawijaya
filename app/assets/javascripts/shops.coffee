ready = ->
  DayTaken = ""
  First = 0

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

  $('.add_fields').click (e) ->
    if First == 1 && $('.nested-fields').length > 0
      partial = $('.nested').eq(-1)
      partial_selects = partial.find('select')

      day   = $(partial_selects[0]).find("option:selected").text()
      open  = $(partial_selects[1]).find("option:selected").text()
      close = $(partial_selects[2]).find("option:selected").text()

      if open != "Choose hour" && close != "Choose hour"
        DayTaken = $('.day-work:visible').text()
        if (DayTaken.indexOf(day) < 0)

          $('.nested-fields').eq(-1).addClass("row")
          partial.addClass("col-md-3")

          $("<span />", { text: day,  class: "day-work"  }).insertAfter(partial_selects[0]);
          $("<span />", { text: open, class: "open-hour" }).insertAfter(partial_selects[1]);
          $("<span />", { text: close }).insertAfter(partial_selects[2]);

          partial.find('select').hide()
          partial.find('label').hide()
          $('.nested-fields').eq(-1).find('.btn-remove').removeClass("hide");

        else
          alert("Day already setting");
          e.stopPropagation();
      else
        alert "Please choose the hour"
        e.stopPropagation();

    else
      First++

  if $('.edit_shop').length > 0
    $('.nested-fields:last').remove();
    $('.nested-fields').each (index, value)->
      nested =  $(".nested-fields .nested")[index]
      partial_selects = $(nested).find('select')
      day   = $(partial_selects[0]).find("option:selected").text()
      open  = $(partial_selects[1]).find("option:selected").text()
      close = $(partial_selects[2]).find("option:selected").text()

      $(this).addClass("row")
      $(nested).addClass("col-md-3")

      $("<span />", { text: day,  class: "day-work"  }).insertAfter(partial_selects[0]);
      $("<span />", { text: open, class: "open-hour" }).insertAfter(partial_selects[1]);
      $("<span />", { text: close }).insertAfter(partial_selects[2]);

      $(nested).find('select').hide()
      $(nested).find('label').hide()
      $(this).find('.btn-remove').removeClass("hide");

  $(".edit_shop").submit (e) ->
    if $('.category-title').length <= 0
      alert "Please choose at least 1 category"
      e.preventDefault()
    else
      if $(".nested-fields .nested:last .select:visible").length > 0
        $(".nested-fields .nested:last .select:visible").remove()

  $(".new_shop").submit (e) ->
    if $('.category-title').length <= 0
          alert "Please choose at least 1 category"
          e.preventDefault()
    else

$(document).ready ready
$(document).on "page:load", ready