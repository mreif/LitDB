# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#add_fields_author').click ->
    if $('#add_fields_author').val() == 'additional fields'
      $('.extra_info_author').css('display', 'block')
      $('#add_fields_author').val('hide additional fields')
    else 
      $('.extra_info_author').css('display', 'none')
      $('#add_fields_author').val('additional fields')