$(document).on 'click', '.tabs li a[href^="#"]', ->
  link = $(this)
  tabs = link.parents('.tabs')
  
  # Remove active
  $('.tab-content').removeClass('active')
  tabs.find('li').removeClass('active')

  # Add active
  link.parent('li').addClass('active')
  $(link.attr('href')).addClass('active')

  return false