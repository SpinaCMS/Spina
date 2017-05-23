ready = ->
  if $('nav#primary ul li ul li.active').length > 0
    $('nav#primary > ul > li').removeClass('active')
    $('nav#primary ul li ul li.active').parents('li').addClass('active')

$(document).on 'turbolinks:load', ready

$(document).on 'click', 'nav#primary a.back-to-main-menu', (e) ->
  $('nav#primary').addClass('animated')
  $('nav#primary').removeClass('transformed')
  e.preventDefault()

$(document).on 'click', 'nav#primary a:not(.back-to-main-menu)', (e) ->
  $('nav#primary ul li ul li').removeClass('active')
  $(this).parent().addClass('active')
  clearTimeout(navigationTimer)

$(document).on 'click', 'nav#primary > ul > li > a', (e) ->
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
  $('nav#primary ul li ul li').removeClass('active')
  $(this).parent().find('ul li:first-child').addClass('active')

delay = 200
navigationTimer = null

$(document).on 'mouseenter', 'nav#primary.transformed > ul > li:not(.active) > a', (e) ->
  navigationTimer = setTimeout(->
    $('nav#primary').addClass('animated')
    $('nav#primary').removeClass('transformed')
  , delay)

$(document).on 'mouseleave', 'nav#primary.transformed > ul > li:not(.active) > a', (e) ->
  clearTimeout(navigationTimer)
