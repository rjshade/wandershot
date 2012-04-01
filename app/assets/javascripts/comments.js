$(document).ready(function(){
  $(".delete-comment").live('ajax:complete', function(event, xhr, status) {
    $(this).parent().toggle('fast', function(){ $(this).remove(); });
  });
  $("#new_comment").bind('ajax:success', function(event, data, status, xhr) {
    $(xhr.responseText).hide().prependTo("#comment-block").fadeIn('slow');
  });
});
