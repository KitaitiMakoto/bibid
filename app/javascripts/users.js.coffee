$('.edit-area a.opener').on 'click', (event) ->
  $trigger = $(event.target)
  $trigger.hide()
  $('form', $trigger.closest('.edit-area')).show()
$('.edit-area a.closer').on 'click', (event) ->
  $trigger = $(event.target)
  $trigger.closest('form').hide()
  $('a.opener', $trigger.closest('.edit-area')).show()
unless $('.field-errors').length == 0
  $('.edit-area a.opener').click()
