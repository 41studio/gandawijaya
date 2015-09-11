//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require pages
//= require shops
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

// $(document).on("page:load", function(){
//   $(':radio').change(  function(){    $('.choice').text( this.value + ' stars' );  } )
// });

});
