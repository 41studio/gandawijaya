$(".modal-body-content").html("<%= j render partial: 'pages/offer', collection: @offers, as: :offer %>");
$('.modal-body-content')[0].scrollTop = $('.modal-body-content')[0].scrollHeight;
$('#offer_content').val("");
$('.js-all-user-offer').html("<%= j render partial: 'shared/modal_offer_user', collection: @offer_rooms, as: 'room', locals: {type_req: '"+ @type_req +"'} %>")


