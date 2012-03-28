# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# for triggering modal login/signup dialogs
jQuery ->
  # first change link target
  $('.join-button').attr('href', null)

  # now trigger modal
  $('.join-button').click ->
    $('#signup-modal').modal('show')

  # first change link target
  $('.login-button').attr('href', null)

  # now trigger modal
  $('.login-button').click ->
    $('#login-modal').modal('show')
