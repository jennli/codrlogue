// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require jquery.turbolinks
//= require chosen-jquery
//= require messages
//= require_tree .
//= require jquery-ui
//= require jquery-ui/autocomplete
//= require autocomplete-rails

$(document).ready(function() {

  // Edit Users Pages

  // Appends character count span on first keyup. Rewrites inner html afterwards.
  var summaryTextarea = $(".edit-summary textarea"),
  descriptionTextarea = $(".edit-description textarea");

  summaryTextarea.on('keyup', function(){

    var maxNum = 140;
    var currentNum = $(this).val().length;
    var numsLeft = maxNum - currentNum;

    if( $(".edit-summary").find('.summary-count').length < 1 ){
      $(this).prev().after("<span class='summary-count count'>" + numsLeft + " characters left...</span>");
    } else if (numsLeft === 0){
      $('.summary-count').html("Max characters achieved");
    } else {
      $('.summary-count').html(numsLeft + " characters left...");
    }


    $('.summary-count').show();
  });


  descriptionTextarea.on('keyup', function(){

    var maxNum = 500;
    var currentNum = $(this).val().length;
    var numsLeft = maxNum - currentNum;

    if( $(".edit-description").find('.description-count').length < 1 ){
      $(this).prev().after("<span class='description-count count'>" + numsLeft + " characters left...</span>");
    } else {
      $('.description-count').html(numsLeft + " characters left...");
    }

    $('.description-count').show();
  });


  // Fades out character count span when text area is out of focus
  $(".basic-right-col textarea").focusout(function(){
    $('span.count').fadeOut(1500);
  });

  // 'Toggle' functionality for forms in user show page
  $('#toggle-skill-form').on('click',function(){
    if ($('#skill-form').is(":visible")){
      $('#new-skill #skill-form').slideUp();
    }
    else {
      $('#new-skill #skill-form').slideDown();
    }});

    $('#toggle-project-form').on('click',function(){
      if($("#project-form").is(":visible")){
        $('#new-project #project-form').slideUp();
      }
      else{
        $('#new-project #project-form').slideDown();
      }
    });

    $('#toggle-education-form').on('click',function(){
      if($("#education-form").is(":visible")){
        $('#new-education #education-form').slideUp();
      }
      else{
        $('#new-education #education-form').slideDown();
      }
    });

      $('#toggle-employment-form').on('click',function(){
        if($("#employment-form").is(":visible")){
          $('#new-employment #employment-form').slideUp();
        }
        else{
          $('#new-employment #employment-form').slideDown();
        }
      });
    });
