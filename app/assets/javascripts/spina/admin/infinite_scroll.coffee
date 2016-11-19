class Spina.InfiniteScroll
  @init: (link) ->
    $(window).off('scroll.infiniteScroll')
    $('#main, #overlay section').off('scroll.infiniteScroll')

    $link = $(link)
    if (url = $link.find('a').attr('href'))
      $(window).on 'scroll.infiniteScroll', => @loadNextPage($link)
      $('#main, #overlay section').on('scroll.infiniteScroll', -> $(window).trigger 'scroll.infiniteScroll')
      $(window).trigger('scroll.infiniteScroll')

  @loadNextPage: ($link) ->
    if ($(window).scrollTop() > $link.offset().top - $(window).height() - 500)
      $(window).off('scroll.infiniteScroll')
      $('#main, #overlay section').off('scroll.infiniteScroll')
      $.rails.disableElement($link.find('a'))
      $.getScript($link.find('a').attr('href'))

$.fn.infiniteScroll = () ->
  Spina.InfiniteScroll.init(this)

$(document).on 'turbolinks:load', ->
  $(window).off('scroll.infiniteScroll')
  $('#main, #overlay section').off('scroll.infiniteScroll')
  $(document).find('.infinite-pagination').infiniteScroll()