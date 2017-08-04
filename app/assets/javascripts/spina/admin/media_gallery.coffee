ready = ->
  $('.media-folder').droppable(
    drop: (event, ui) ->
      $(ui.draggable).addClass('dropped').fadeOut()
      photoCount = parseInt($(this).find('.media-folder-thumbnail').attr('data-badge'))
      imgSrc = $(ui.draggable).find('img').attr('src')

      $(this).removeClass('dropping')
      $(this).find('.media-folder-thumbnail').attr('data-badge', photoCount + 1)
      $(this).find('.media-folder-thumbnail img').attr('src', imgSrc)

      url = $(this).attr('data-add-to-media-folder-url')
      photo_id = $(ui.draggable).find('input[type="radio"]').val()

      $.ajax({
        url: url,
        type: 'PUT',
        data: {
          photo_id: photo_id
        },
        dataType: 'json',
        success: (result) ->
          console.log result
      })

    over: (event, ui) ->
      $(ui.draggable).addClass('dropping')

      $(this).addClass('dropping')
    out: (event, ui) ->
      $(ui.draggable).removeClass('dropping')

      $(this).removeClass('dropping')
  )

  $('.gallery .infinite-scroll .item').draggable(
    revert: 'invalid'
  )

$(document).on 'turbolinks:load', ready