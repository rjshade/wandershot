jQuery ->
  $(document).ready( -> fadeOut('.clutter') )
  $(document).ready( -> fadeOut('.minor-clutter') )
  $(document).ready(
    $('.markdown-examples-toggle').attr('href', null)
    $('.markdown-examples-toggle').bind 'click', -> 
      $('.markdown-examples').toggle('fast')
  )

  fadeOut = (element, opacity = 0.0, delay = 4000) ->
    $(element).addClass('toFadeOut')
    hover_intent = setTimeout( (-> $(element+'.toFadeOut').fadeTo('slow', opacity);), delay );

  fadeIn = (element) ->
    try
      clearTimeout(hover_intent);
    $(element+'.toFadeOut').fadeTo('fast',1.0);
    $(element).removeClass('toFadeOut');

  $('.clutter').hover( 
    -> fadeIn('.clutter')
    -> fadeOut('.clutter', 0.0)
  )
  $('.post').hover(
    -> fadeIn('.minor-clutter')
    -> fadeOut('.minor-clutter')
  )
  $('.story').hover(
    -> fadeIn('.minor-clutter')
    -> fadeOut('.minor-clutter')
  )
