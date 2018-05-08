# Scaffold
$(document).on 'click', '.table-clickable tr', (e) ->
  $row = $(this).closest('tr')
  link = $row.find('a.table-link:first')[0]
  if link
    link.click()
  else
    checkbox = $(this).find('input[type="checkbox"]:first, input[type="radio"]:first')

    if checkbox.length > 0

      # Get shifty
      if !checkbox.prop("checked") && e.shiftKey
        $firstRow = $('.table-clickable tr input[type="checkbox"]:checked:first').closest('tr')

        if $firstRow.index() < $row.index()
          $firstRow.nextUntil($row).each ->
            $(this).find('input[type="checkbox"]:first').prop("checked", true)
        else
          $firstRow.prevUntil($row).each ->
            $(this).find('input[type="checkbox"]:first').prop("checked", true)
        document.getSelection().removeAllRanges()

      checkbox.prop("checked", !checkbox.prop("checked"))
      checkbox.trigger('checked')
      e.stopPropagation()

$(document).on 'click', '.table-clickable .table-link', (e) ->
  e.stopPropagation()

$(document).on 'click', '.table-clickable tr input', (e) ->
  e.stopPropagation()

# Search inputs
$(document).on 'keyup', '.search-input input', (e) ->
  $(this).parent().removeClass('animated small-shake')
  if $(this).val() == ""
    $(this).parent().find('.clear-input').fadeOut(200)
    if e.keyCode == 13
      $(this).parent().addClass('animated small-shake')
  else
    $(this).parent().find('.clear-input').fadeIn(200)

$(document).on 'click', '.clear-input', ->
  link = $(this)
  input = link.siblings('input')
  input.val("")
  input.focus()
  input.trigger("keyup")
  link.fadeOut(200)
  return false

$(document).on 'keyup + change', '.table-container .search-input input', ->
  datatable = $(this).parent().parent().find('table.datatable').dataTable()
  datatable.fnFilter($(this).val())

$(document).on 'change', '.dd', ->
  serialized = $(this).nestable('serialize')
  sort_url = $(this).data('sort-url')
  $.post sort_url, { list: serialized }

ready = ->

  # Set paddingTop for section#main
  if header = document.getElementById('header')
    headerHeight = header.getBoundingClientRect().height
    $('section#main').css({paddingTop: headerHeight})

  # Login wrapper
  $('#login_wrapper').css('margin-top', $(document).innerHeight() / 8)

  # Custom file
  $('input[type="file"][data-customfileinput]:visible').each ->
    $(this).customFileInput()

  $(".structure-form-menu ul").sortable
    handle: '.sortable-handle'

  # Switch
  if $('input[data-switch]').length > 0
    $('input[data-switch]').spinaSwitch()

  # Datepicker
  if $('.datepicker').length > 0
    $('.datepicker').datepicker
      dateFormat: "dd-mm-yy"
      firstDay: 1

$(document).on 'turbolinks:load', ready
