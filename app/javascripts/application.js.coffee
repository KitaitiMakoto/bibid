//= require_tree .

$uploadFormContainer = $('.upload-form')
$('input#book_epub', $uploadFormContainer).on 'change', (event) ->
  $('label[for="book_epub"]').hide()
  $(event.target).show()
  $('input[type="submit"]', $uploadFormContainer).show()
