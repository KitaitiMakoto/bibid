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
    'click .iframe-size': 'changeIframeSize'
    'change .iframe-size-input input': 'render'
  deactivateSizeInput: ->
    @$customizingListItems.removeClass 'active'
  changeIframeSize: (event) ->
    @deactivateSizeInput()
    $selected = $(event.target)
    $selected.addClass 'active'
    $iframe = $('.embedded iframe')
    newBibiWidth = $selected.data("bibiStyleWidth")
    newBibiHeight = $selected.data("bibiStyleHeight")
    @$iframeSizeInputWidth.val newBibiWidth
    @$iframeSizeInputHeight.val newBibiHeight
    @render()
  render: (event) ->
    @deactivateSizeInput()
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
