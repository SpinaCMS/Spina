$(document).on 'click', '.notification [data-close-notification]', (e) ->
  $notification = $(this).parents('.notification')
  $notification.removeClass('fadeInLeft').addClass('fadeOutLeft')
  setTimeout ->
    $notification.remove()
  , 400
  e.preventDefault()