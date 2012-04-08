$(document).ready(function(){
  $(".delete-comment").live('ajax:complete', function(event, xhr, status) {
    $(this).closest('.comment').fadeOut('fast')
  });
  $("#new_comment").bind('ajax:success', function(event, data, status, xhr) {
    $(xhr.responseText).hide().appendTo("#comment-block").fadeIn('fast');
    $('#comment_text').attr('value', ''); // clear input box 
  });

  // controls are initially hidden with opacity 0
  $('.comment').children('.controls').css({ opacity: 0.0 })
  $('.comment').hover( function(){
    // on hover they fade in so visible
    $(this).children('.controls').fadeTo('fast',1);
  },
  function() {
    // and fade out again...
    $(this).children('.controls').fadeTo('fast',0);
  });
});
