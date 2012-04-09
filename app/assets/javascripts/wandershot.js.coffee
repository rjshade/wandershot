jQuery ->
  $(document).ready( -> fadeOut('.clutter'))
 
  fadeOut = (element) ->
    $(element).addClass('toFadeOut')
    hover_intent = setTimeout( (-> $(element+'.toFadeOut').fadeTo('slow',0.0);) , 500 );

  fadeIn = (element) ->
    try
      clearTimeout(hover_intent);
    $(element+'.toFadeOut').fadeTo('fast',1.0);
    $(element).removeClass('toFadeOut');

  $('.clutter').hover( 
    -> fadeIn('.clutter')
    -> fadeOut('.clutter')
  )
