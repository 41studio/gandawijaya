//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require pages
//= require shops
//= require offer
//= require cocoon
//= require turbolinks


$(document).ready(function() {
$('[data-toggle="tooltip"]').tooltip();
$("#myCarousel").carousel();
$("#myModal").on('show.bs.modal', function(event){
        var button = $(event.relatedTarget);  // Button that triggered the modal
        var titleData = button.data('title'); // Extract value from data-* attributes
        $(this).find('.modal-title').text(titleData + ' Form');

    });

$(".close").click(function(){
    $("#myAlert").alert('close');
  });

    // if close == "Closed"
    //   open = close
    //   $(partial_selects[1]).find("option:selected").val = $(partial_selects[2]).find("option:selected").val

    // if open == "Closed"
    //   close = open
    //   $(partial_selects[2]).find("option:selected").val = $(partial_selects[1]).find("option:selected").val
    // $('.nested-fields').eq(-1).find('.btn-remove').removeClass('hide')

});
