# jQuery plugin checkbox
$.fn.spinaSwitch = ->
  return this.each ->
    unless $(this).attr('data-plugin-switch')
      input = $(this)
      input.attr('data-plugin-switch', true)
      input.hide()

      # Check if it is checked
      if input.is(':checked')
        klass = "switch active"
      else
        klass = "switch"

      # Insert new HTML into the DOM
      input.after('<a href="#' + input.attr("id") + '" class="' + klass + '">
                    <span class="knob"></span>
                  </a>')

# Click handlers for checkbox
$(document).on 'click', 'a.switch', (e) ->
  toggleSwitch(e)

$(document).on 'touchend', 'a.switch', (e) ->
  toggleSwitch(e)

toggleSwitch = (e) ->
  checkbox = $(e.currentTarget)
  input = $(checkbox.attr("href"))

  if checkbox.hasClass('activated') || checkbox.hasClass('active') 
    checkbox.removeClass('active')
    checkbox.removeClass('activated')
    checkbox.addClass('deactivated')
    input.prop("checked", false)
  else
    checkbox.addClass('activated')
    checkbox.removeClass('deactivated')
    input.prop("checked", true)

  input.trigger('change')

  return false
