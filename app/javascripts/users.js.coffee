User = Backbone.Model.extend
  urlRoot: '/users',
  idAttribute: 'name'

UserView = Backbone.View.extend
  el: '.edit-area',
  initialize: ->
    @$opener = @$('.opener')
    @$form = @$('form')
    unless @$('.field-errors').length == 0
      @toggleEditArea()
    @model = new User(name: @$form.data('name'))
    @listenTo @model, 'change', @render
  events:
    'click .opener, .closer': 'toggleEditArea',
    'submit form': (event) ->
      @model.set 'display_name', @$('input[name="user[display_name]"]').val()
      @model.save null,
        beforeSend: (xhr) =>
          xhr.setRequestHeader 'X-CSRF-Token', @$('input[name="authenticity_token"]').val()
      event.preventDefault()
  render: ->
    displayName = @model.get('display_name')
    $('.user-name').text displayName
    @toggleEditArea()
    @
  toggleEditArea: (event) ->
    @$opener.toggle()
    @$form.toggle()

UserFeedsView = Backbone.View.extend
  el: '.feeds',
  events:
    'click h4, li': 'toggleLinks'
  toggleLinks: (event) ->
    return if _.contains ['A', 'TEXTAREA'], $(event.target)[0].nodeName
    $(@el).toggleClass 'shrinked'

new UserView
new UserFeedsView
