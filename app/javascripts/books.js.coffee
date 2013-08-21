BookControlsView = Backbone.View.extend
  el: '#book-controls'
  initialize: ->
    @$iframeSizeButton = @$('.iframe-size')
    @$iframeSizeInput = @$('.iframe-size-input')
    @$textarea = $('#embedding-tag')
    @$customizingListItems = @$('.customizing li')
    @width = @height = null
    @$width = @$('input[name="width"]')
    @$height = @$('input[name="height"]')
  events:
    'click .iframe-size': 'changeIframeSizeByButton'
    'change .iframe-size-input input': 'changeIframeSizeByInput'
  deactivateSizeInput: ->
    @$customizingListItems.removeClass 'active'
  changeIframeSizeByButton: (event) ->
    @deactivateSizeInput()
    $selected = $(event.target)
    $selected.addClass 'active'
    @width = $selected.data("bibiStyleWidth")
    @height = $selected.data("bibiStyleHeight")
    @render()
  changeIframeSizeByInput: (event) ->
    @deactivateSizeInput()
    @width = @$width.val()
    @height = @$height.val()
    @render()
  render: ->
    newBibiStyle =
      if @width && @height
        "width: #{@width}px; height: #{@height}px;"
      else
        "width: 100%; height: 100%;"
    currentTag = @$textarea.val()
    newTag = currentTag.replace(/data\-bibi\-style=\"[^"]+\"/, "data-bibi-style=\"#{newBibiStyle}\"")
    @$textarea.val newTag
    $('.embedded iframe').attr 'style', newBibiStyle
    @$width.val @width
    @$height.val @height
    @

new BookControlsView
