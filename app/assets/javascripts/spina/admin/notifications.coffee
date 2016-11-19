$(document).on 'click', '.notification [data-close-notification]', (e) ->
  $notification = $(this).parents('.notification')
  $notification.removeClass('fadeInRight').addClass('fadeOutRight')
  setTimeout ->
    $notification.remove()
  , 400
  e.preventDefault()