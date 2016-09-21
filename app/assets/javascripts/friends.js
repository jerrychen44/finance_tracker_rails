//ref: http://www.w3schools.com/ajax/default.asp
//copy from friends.js, and replace all friend to friend
var init_friend_lookup;


init_friend_lookup = function(){
  //[Jerry]we want the spinner shows up.
  $('#friend-lookup-form').on('ajax:before',function(event,data,status){
    show_spinner();
  });
  //[Jerry]after the ajax request completed, we want to hide the spinner
  $('#friend-lookup-form').on('ajax:after',function(event,data,status){
    hide_spinner();
  });



  //when friend query success
  $('#friend-lookup-form').on('ajax:success',function(event,data,status){
    //<div id="friend-lookup"> in _lookup.html.erb
    $('#friend-lookup').replaceWith(data);

    //reinitialize the init_friend_lookup again.
    //you need keep has a listener.
    init_friend_lookup();
  });

  //handle quote error
  $('#friend-lookup-form').on('ajax:error', function(event, xhr, status, error){
    //let spinner hide
    hide_spinner();
    $('#friend-lookup-results').replaceWith(' ');
    $('#friend-lookup-errors').replaceWith('Person was not found');
  });


}



$(document).ready(function() {


  init_friend_lookup();

})
