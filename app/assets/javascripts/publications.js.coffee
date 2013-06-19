# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#srch').keyup -> 
    val = $('#srch').val().toLowerCase().replace(/\ /g, '-')
    if (val == "")
      $(".publication").show()
    else
      $(".publication[id*="+val+"]").show()
      $(".publication:not([id*="+val+"])").hide()
      
jQuery ->
  $('#publication_author_tokens').tokenInput '/authors.json',
    propertyToSearch: 'search_name',
    preventDuplicates: true,
    prePopulate: $('#publication_author_tokens').data('load')
        
jQuery -> 
    $('#publication_type_id').change ->
     $('.all').hide()
     switch $('#publication_type_id').val()
       when "1" # book
        $(".important").show()
        $(".book").show()
        $(".inproceedings").show()
       when "2" # generic
        $(".important").show()
        $(".type_of_work").show()
       when "3" # report
        $(".important").show()
        $(".publisher").hide()
        $(".instituion").show()
       when "4" # thesis
        $(".important").show()
        $(".publisher").hide()
        $(".university").show()
        $(".department").show()
       when "5" # webpage
        $(".important").show()
        $(".publisher").hide()
        $(".city").hide()
        $(".date_of_last_access").show()
       when "6" # paper
        $(".important").show()
        $(".instituion").show()
        $(".university").show()
       when "7" # article
        $(".important").show()
        $(".article").show()
       when "8" # inProceedings
        $(".important").show()
        $(".article").show()
        $(".inproceedings").show()
       else
         
jQuery ->
  $ ->
  $("#publication_type_id").trigger("change")
  
jQuery -> 
  $(".bbtn").click -> 
    num = this.id.substring(this.id.length-1, this.id.length);
    id = '#bibtex'+num
    if $(id).is(":visible")
      $(id).hide()
    else
      $(id).show()  
  
jQuery ->
  $('#add_fields_publication').click ->
    if $('#add_fields_publication').val() == 'additional fields'
      $('.all').show()
      $('.additional').show()
      $('#add_fields_publication').val('hide additional fields')
    else 
      $('.additional').hide()
      $("#publication_type_id").trigger("change");
      $('#add_fields_publication').val('additional fields')