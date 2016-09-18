//ref: http://www.w3schools.com/ajax/default.asp
var init_stock_lookup;


init_stock_lookup = function(){
  //[Jerry]we want the spinner shows up.
  $('#stock-lookup-form').on('ajax:before',function(event,data,status){
    show_spinner();
  });
  //[Jerry]after the ajax request completed, we want to hide the spinner
  $('#stock-lookup-form').on('ajax:after',function(event,data,status){
    hide_spinner();
  });



  //when stock query success
  $('#stock-lookup-form').on('ajax:success',function(event,data,status){
    //<div id="stock-lookup"> in _lookup.html.erb
    $('#stock-lookup').replaceWith(data);

    //reinitialize the init_stock_lookup again.
    //you need keep has a listener.
    init_stock_lookup();
  });

  //handle quote error
  $('#stock-lookup-form').on('ajax:error', function(event, xhr, status, error){
    //let spinner hide
    hide_spinner();
    $('#stock-lookup-results').replaceWith(' ');
    $('#stock-lookup-errors').replaceWith('Stock was not found');
  });


}



$(document).ready(function() {


  init_stock_lookup();

})
