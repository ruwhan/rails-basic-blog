# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

split = (val) ->
  val.split( /,\s*/ );

extractLast = (term) ->
  split( term ).pop();


jQuery ->
  autoProp = 
    source: (request, response) -> 
      $.getJSON('/admin/tags.json', { term: extractLast(request.term) }, response)
    search: ->
      term = extractLast this.value
      if term.length == 0
        false
    focus: ->
      false
    select: (event, ui) ->
      terms = split this.value
      terms.pop()
      terms.push  ui.item.value
      terms.push ""
      this.value = terms.join(', ')
      false
    #minLength: 1
      
    
  $('#post-tags').bind('keydown', (event) -> 
    if event.keycode == $.ui.keyCode.TAB and $(this).data('autocomplete').menu.active
      event.preventDefault()
      false).autocomplete(autoProp)
