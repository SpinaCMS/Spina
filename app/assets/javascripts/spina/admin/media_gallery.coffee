$(document).on 'click', '.organize-switch', (e) ->
  $items = $('.gallery .infinite-scroll .item')
  disabled = $items.draggable('option', 'disabled')
  if disabled 
    $(this).addClass('button-success')
    $(this).text($(this).attr('data-done-organizing'))
    $(this).prepend('<i class="icon icon-random"></i>')
  else 
    $(this).removeClass('button-success')
    $(this).text($(this).attr('data-organize-images'))
    $(this).prepend('<i class="icon icon-random"></i>')
  $items.draggable('option', 'disabled', !disabled)
  e.preventDefault()

ready = ->
  $('.media-folder').droppable(
    drop: (event, ui) ->
      url = $(this).attr('data-add-to-media-folder-url')
      photo_id = $(ui.draggable).find('input[type="radio"]').val()

      $.ajax
        url: url,
        type: 'PUT',
        data: {
          photo_id: photo_id
        },
        dataType: 'json',
        success: (result) =>
          $(ui.draggable).addClass('dropped').fadeOut()
          photoCount = parseInt($(this).find('.media-folder-thumbnail').attr('data-badge'))
          imgSrc = $(ui.draggable).find('img').attr('src')

          $(this).removeClass('dropping')
          $(this).find('.media-folder-thumbnail').attr('data-badge', photoCount + 1)
          $(this).find('.media-folder-thumbnail img').attr('src', imgSrc)

    over: (event, ui) ->
      $(ui.draggable).addClass('dropping')

      $(this).addClass('dropping')
    out: (event, ui) ->
      $(ui.draggable).removeClass('dropping')

      $(this).removeClass('dropping')
  )

  $('.gallery .infinite-scroll .item').draggable(
    revert: 'invalid',
    disabled: true
  )

$(document).on 'turbolinks:load', ready