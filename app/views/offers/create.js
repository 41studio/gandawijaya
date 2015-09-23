$(".modal-body-content").html("<%= j render partial: 'pages/offer', collection: @offers, as: :offer %>");
$('#offer_content').val("")
