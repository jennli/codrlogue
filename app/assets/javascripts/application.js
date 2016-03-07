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




$("document").ready(function(){

  // Edit Users Page

  var summaryTextarea = $(".edit-summary textarea"),
      descriptionTextarea = $(".edit-description textarea");

  summaryTextarea.on('keyup', function(){

    var maxNum = 140;
    var currentNum = $(this).val().length;
    var numsLeft = maxNum - currentNum;

    if( $(".edit-summary").find('.char-count').length < 1 ){
      $(this).prev().after("<span class='char-count'>" + numsLeft + " characters left...</span>");
    } else {
      $('.char-count').html(numsLeft + " characters left...");
    }

    $('.char-count').show();
  });

  summaryTextarea.focusout(function(){
    $('.char-count').fadeOut(1500);
  });


  $(".basic-right")












});