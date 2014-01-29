# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#project_publication_tokens').tokenInput '/publications.json',
    propertyToSearch: 'title',
    preventDuplicates: true,
    prePopulate: $('#project_publication_tokens').data('load')