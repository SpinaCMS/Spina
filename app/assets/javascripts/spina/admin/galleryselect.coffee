$(document).on 'click', '.gallery .item:not(.item-uploader)', ->
  gallery = $(this).parents('.gallery')

  if gallery.data('multiselect') != undefined
    $(this).toggleClass('selected')
    checkbox = $(this).find('input:checkbox')
    checkbox.prop("checked", !checkbox.prop("checked"))
    $form = $(this).closest('form')
    count = $form.find('.item.selected').size()
    if count > 0
      $form.find('.gallery-select-counter').text("(#{count})")
    else
      $form.find('.gallery-select-counter').text("")
  else
    checked = $(this).find('input').prop('checked')
    gallery.find('.item').removeClass('selected')
    gallery.find('.item input').prop('checked', false)
    $(this).addClass('selected') unless checked
    $(this).find('input').prop('checked', !checked)
    $(this).closest('form').submit()
