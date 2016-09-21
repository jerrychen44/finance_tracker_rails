// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

// [Jerry] the first time do the friend search will have no response.
// remove turbolinks for above issue. remvoe the "="
// require turbolinks
//= require_tree .

//[Jerry] add this to control when to show the spinner or not in stocks.js
var hide_spinner = function(){

  $('#spinner').hide();
}


var show_spinner= function(){

  $('#spinner').show();
}
