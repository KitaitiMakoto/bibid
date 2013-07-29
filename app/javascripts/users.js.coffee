UserView = Backbone.View.extend
  el: '.edit-area',
  initialize: ->
    @$opener = @$('.opener')
    @$form = @$('form')
    unless @$('.field-errors').length == 0
      @toggleEditArea()
  events:
    'click .opener, .closer': 'toggleEditArea'
  toggleEditArea: (event) ->
    @$opener.toggle()
    @$form.toggle()
view = new UserView
