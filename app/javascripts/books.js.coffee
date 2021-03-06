_.templateSettings =
  interpolate: /\{\{(.+?)\}\}/g

BookControlsView = Backbone.View.extend
  el: '#book-controls'
  initialize: ->
    @$textarea = $('#embedding-tag')
    @$customizingListItems = @$('.customizing li')
    @width = @height = null
    @$width = @$('input[name="width"]')
    @$height = @$('input[name="height"]')
    @$active = null
    templateString = $('#embedding-tag-template').html()
    @embeddingTagTemplate = _.template(templateString) if templateString
  events:
    'click .iframe-size': 'changeIframeSizeByButton'
    'change .iframe-size-input input': 'changeIframeSizeByInput'
  changeIframeSizeByButton: (event) ->
    $selected = $(event.target)
    @$active = $selected
    @width = $selected.data("bibiStyleWidth")
    @height = $selected.data("bibiStyleHeight")
    @render()
  changeIframeSizeByInput: (event) ->
    @$active = null
    @width = @$width.val()
    @height = @$height.val()
    @render()
  render: ->
    @$customizingListItems.removeClass 'active'
    @$active?.addClass('active')
    style =
      if @width && @height
        "width: #{@width}px; height: #{@height}px;"
      else
        "width: 100%; height: 100%;"
    currentTag = @$textarea.val()
    newTag = @embeddingTagTemplate(style: style)
    @$textarea.val newTag
    $('.embedded .bibi-holder').attr 'style', style
    $('.embedded').css 'height', @height
    @$width.val @width
    @$height.val @height
    @

new BookControlsView
