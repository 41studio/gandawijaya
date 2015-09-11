#= require active_admin/base
ready = ->

  if @checked
    $('#premium_account_url').prop('disabled', false);
  else
    $('#premium_account_url').prop('disabled', true);

  $('#premium_account_status').change ->
    if @checked
      $('#premium_account_url').prop('disabled', false);
    else
      $('#premium_account_url').prop('disabled', true);

$(document).ready ready
$(document).on "page:load", ready
