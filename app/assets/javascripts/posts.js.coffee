jQuery ->
  $('a.lightbox').colorbox( {
    transition: 'fade',
    maxHeight: '95%',
    maxWidth: '95%'
  });

  `$(document).keydown(function (evt) {
    if( evt.keyCode === 39 || evt.keyCode === 40 ) {
      var href = $('.next').find('a').attr('href');
      if( href ) { window.location.href = href }
    }
    if( evt.keyCode === 37 || evt.keyCode === 38 ) {
      var href = $('.prev').find('a').attr('href');
      if( href ) { window.location.href = href }
    }
  });`
