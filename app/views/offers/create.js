$(".modal-body-content").html("<%= j render partial: 'pages/offer', collection: @offers, as: :offer %>");
$('.modal-body-content')[0].scrollTop = $('.modal-body-content')[0].scrollHeight;
$('#offer_content').val("")

