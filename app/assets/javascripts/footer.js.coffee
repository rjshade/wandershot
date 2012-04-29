jQuery ->
  desktop = ($(document).width() >= 800 )
  if !desktop
    $('.footer').toggle()
