jQuery ->
  $(document).ready( -> fadeOut('.clutter'))
  $(document).ready( -> fadeOut('.minor-clutter'))
 
  fadeOut = (element, opacity = 0.0) ->
    $(element).addClass('toFadeOut')
    hover_intent = setTimeout( (-> $(element+'.toFadeOut').fadeTo('slow', opacity);) , 1500 );

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
