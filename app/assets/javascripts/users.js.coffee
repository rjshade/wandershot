# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# for triggering modal login/signup dialogs
jQuery ->
  $(".login-button").click ->
    target = ($ @).attr('data-target')
    url = ($ @).attr('href')
    $(target).load('/users/login #modal-block');

  $(".join-button").click ->
    target = ($ @).attr('data-target')
    url = ($ @).attr('href')
    $(target).load('/users/signup #modal-block');
