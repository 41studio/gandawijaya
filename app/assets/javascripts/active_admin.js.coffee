#= require active_admin/base
ready = ->

  if $('#premium_account_status').is(':checked')
    $('#premium_account_url').prop('disabled', false);
  else
    $('#premium_account_url').prop('disabled', true);

  $('#premium_account_status').change ->
    if @checked
      $('#premium_account_url').prop('disabled', false);
    else
      $('#premium_account_url').prop('disabled', true);

  $('#shop_premium_account_attributes_status').change ->
    if @checked
      $('#shop_premium_account_attributes_url').prop('disabled', false);
    else
      $('#shop_premium_account_attributes_url').prop('disabled', true);

  if $('#shop_premium_account_attributes_status').is(':checked')
    $('#shop_premium_account_attributes_url').prop('disabled', false);
  else
    $('#shop_premium_account_attributes_url').prop('disabled', true);



$(document).ready ready
# $(document).on "page:load", ready
