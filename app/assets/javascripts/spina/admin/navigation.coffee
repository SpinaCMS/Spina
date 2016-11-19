$(document).on 'click', 'nav#primary a.back-to-main-menu', (e) ->
  $('nav#primary').addClass('animated')
  $('nav#primary').removeClass('transformed')
  e.preventDefault()

$(document).on 'click', 'nav#primary:not(.transformed) > ul > li > a', (e) ->
  if $(this).parent().find('ul').length > 0
    e.preventDefault()

    $(this).parent().siblings().removeClass('active')
    $(this).parent().addClass('active')

# Clicking something from the primary menu adds the animation
$(document).on 'click', 'nav#primary:not(.transformed) > ul > li > a', (e) ->
  $('nav#primary').addClass('animated').addClass('transformed')

# Clicking directly on the primary menu when it's transformed removes the animation
$(document).on 'click', 'nav#primary.transformed > ul > li > a', (e) ->
  $('nav#primary').removeClass('animated')