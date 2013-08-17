$('#book-controls .iframe-size').on 'click', (event) ->
  $('.customizing li').removeClass('active')
  $selected = $(event.target)
  $selected.addClass('active')
  $textarea = $('#embedding-tag')
  $iframe = $('.embedded iframe')
  newBibiWidth = $selected.data("bibiStyleWidth")
  newBibiHeight = $selected.data("bibiStyleHeight")
  newBibiStyle = "width: #{newBibiWidth}; height: #{newBibiHeight};"
  unless $selected.hasClass 'default'
    $('#book-controls .iframe-size-input input[name="width"]').val newBibiWidth.replace 'px', ''
    $('#book-controls .iframe-size-input input[name="height"]').val newBibiHeight.replace 'px', ''
  currentTag = $textarea.val()
  newTag = currentTag.replace(/data\-bibi\-style=\"[^"]+\"/, "data-bibi-style=\"#{newBibiStyle}\"")
  $textarea.val newTag
  $iframe.attr 'style', newBibiStyle

$('#book-controls .iframe-size-input').on 'change', (event) ->
  $('.customizing li').removeClass('active')
  $selected = $(@)
  $textarea = $('#embedding-tag')
  $iframe = $('.embedded iframe')
  newBibiWidth = $('input[name="width"]', $selected).val()
  return unless newBibiWidth
  newBibiHeight = $('input[name="height"]', $selected).val()
  return unless newBibiHeight
  newBibiStyle = "width: #{newBibiWidth}px; height: #{newBibiHeight}px;"
  currentTag = $textarea.val()
  newTag = currentTag.replace(/data\-bibi\-style=\"[^"]+\"/, "data-bibi-style=\"#{newBibiStyle}\"")
  $textarea.val newTag
  $iframe.attr 'style', newBibiStyle
  console.log $textarea, $iframe
