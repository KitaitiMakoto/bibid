BookControlsView = Backbone.View.extend
  el: '#book-controls'
  initialize: ->
    @$iframeSizeButton = @$('.iframe-size')
    @$iframeSizeInput = @$('.iframe-size-input')
    @$textarea = $('#embedding-tag')
    @$customizingListItems = $('.customizing li')
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
    newBibiStyle = "width: #{newBibiWidth}; height: #{newBibiHeight};"
    unless $selected.hasClass 'default'
      $('#book-controls .iframe-size-input input[name="width"]').val newBibiWidth.replace 'px', ''
      $('#book-controls .iframe-size-input input[name="height"]').val newBibiHeight.replace 'px', ''
    currentTag = @$textarea.val()
    newTag = currentTag.replace(/data\-bibi\-style=\"[^"]+\"/, "data-bibi-style=\"#{newBibiStyle}\"")
    @$textarea.val newTag
    $iframe.attr 'style', newBibiStyle
  render: (event) ->
    @deactivateSizeInput()
    $selected = $(@)
    newBibiWidth = @$('input[name="width"]', $selected).val()
    newBibiHeight = @$('input[name="height"]', $selected).val()
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
