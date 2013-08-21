BookControlsView = Backbone.View.extend
  el: '#book-controls'
  initialize: ->
    @$iframeSizeButton = @$('.iframe-size')
    @$iframeSizeInput = @$('.iframe-size-input')
    @$textarea = $('#embedding-tag')
    @$customizingListItems = @$('.customizing li')
    @$iframeSizeInputWidth = @$('input[name="width"]')
    @$iframeSizeInputHeight = @$('input[name="height"]')
  events:
    'click .iframe-size': 'changeIframeSizeByButton'
    'change .iframe-size-input input': 'changeIframeSizeByInput'
  deactivateSizeInput: ->
    @$customizingListItems.removeClass 'active'
  changeIframeSizeByButton: (event) ->
    @deactivateSizeInput()
    $selected = $(event.target)
    $selected.addClass 'active'
    newBibiWidth = $selected.data("bibiStyleWidth")
    newBibiHeight = $selected.data("bibiStyleHeight")
    @$iframeSizeInputWidth.val newBibiWidth
    @$iframeSizeInputHeight.val newBibiHeight
    @render()
  changeIframeSizeByInput: (event) ->
    @deactivateSizeInput()
    @render()
  render: ->
    newBibiWidth = @$iframeSizeInputWidth.val()
    newBibiHeight = @$iframeSizeInputHeight.val()
    newBibiStyle =
      if newBibiHeight && newBibiHeight
        "width: #{newBibiWidth}px; height: #{newBibiHeight}px;"
      else
        "width: 100%; height: 100%;"
    currentTag = @$textarea.val()
    newTag = currentTag.replace(/data\-bibi\-style=\"[^"]+\"/, "data-bibi-style=\"#{newBibiStyle}\"")
    @$textarea.val newTag
    $('.embedded iframe').attr 'style', newBibiStyle
    @

new BookControlsView
