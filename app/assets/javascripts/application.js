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
  $('#toggle-skill-form').on('click',function(){$('#skill-form').toggle();});
  $('#toggle-project-form').on('click',function(){$('#project-form').toggle();});
  $('#toggle-education-form').on('click',function(){$('#education-form').toggle();});
  $('#toggle-employment-form').on('click',function(){$('#employment-form').toggle();});

});
