$("#upload-form").submit (event) ->
  $form = $(event.target)
  fd = new FormData($form[0])

  $fileInput = $form.find('input[type="file"]').eq(0)
  unless $fileInput.val()
    alert 'Select file!'
    event.preventDefault()
    $fileInput.focus()
    return

  $('#book iframe:first').slideUp ->
    $.ajax({
      url: $form.attr('action'),
      type: $form.attr('method'),
      data: fd,
      dataType: 'json'
      processData: false,
      contentType: false,
    }).done (data, status, xhr) ->
      $('#upload-form')[0].reset()
      res = JSON.parse(xhr.responseText)
      $('#book iframe:first').attr('src', res.uri).slideDown()
      $('#book #download-link').attr('href', res.src)
      $('#embedding-iframe-tag').val(res.uri)
    .fail ->
      alert("Failed!")

    event.preventDefault()
