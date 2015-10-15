#= require active_admin/base
ready = ->

  if $('#shop_account_status').is(':checked')
    $('#shop_url').prop('disabled', false);
  else
    $('#shop_url').prop('disabled', true);

  $('#shop_account_status').change ->
    if @checked
      $('#shop_url').prop('disabled', false);
    else
      $('#shop_url').prop('disabled', true);

$(document).ready ready
$(document).on "page:load", ready
