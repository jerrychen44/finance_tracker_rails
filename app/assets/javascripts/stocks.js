//ref: http://www.w3schools.com/ajax/default.asp
var init_stock_lookup;


init_stock_lookup = function(){

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
    $('#stock-lookup-results').replaceWith(' ');
    $('#stock-lookup-errors').replaceWith('Stock was not found')
  });


}



$(document).ready(function() {


  init_stock_lookup();

})
