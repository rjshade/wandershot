$(document).ready(function () {
  var $attachElem = $('.attach')
  if( $attachElem.length ) {
    if( $(document).width() >= 800 ) {
      var top = $('.attach').offset().top - parseFloat($('.attach').css('marginTop').replace(/auto/,0));
      var left = $('.attach').offset().left - parseFloat($('.attach').css('marginLeft').replace(/auto/,0));

      $(window).scroll(function (event) {
        var y = $(this).scrollTop();
        var offset = 60; // attach image 60px from top of viewport

        if ((y+ offset)>= top) {
          $('.attach').css('position', 'fixed');
          $('.attach').css('top', offset);
          $('.attach').css('left', left);
        } else {
          $('.attach').css('position', 'relative');
          $('.attach').css('top', 0);
          $('.attach').css('left', 0);
        }
      });
    }
  }
});
