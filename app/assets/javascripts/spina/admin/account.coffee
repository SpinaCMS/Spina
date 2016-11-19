ready = ->
  if $('.account-theme').length > 0
    layout_parts = $('.account-theme').data('layout-parts')
    show_layout_parts(layout_parts)

$(document).on 'turbolinks:load', ready

$(document).on 'change', '.account-theme select', ->
  layout_parts = $(this).find('option:selected').data('layout-parts').split(" ")
  show_layout_parts(layout_parts)

show_layout_parts = (layout_parts) ->
  $('tr.layout-part').hide()
  for layout_part in layout_parts
    if layout_part
      $('tr.layout-part[data-name=' + layout_part + ']').show()
