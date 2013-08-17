$('#book-controls .customizing li').on 'click', (event) ->
  $('.customizing li').removeClass('active')
  $(event.target).addClass('active')
  $textarea = $('#embedding-tag')
  $iframe = $('.embedded iframe')
  newBibiStyle = $(event.target).data("bibiStyle")
  currentTag = $textarea.val()
  newTag = currentTag.replace(/data\-bibi\-style=\"[^"]+\"/, "data-bibi-style=\"#{newBibiStyle}\"")
  $textarea.val newTag
  $iframe.attr 'style', newBibiStyle