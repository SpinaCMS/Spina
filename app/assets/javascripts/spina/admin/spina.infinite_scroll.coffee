class Spina.InfiniteScroll
  @init: (link) ->
    $(window).off('scroll.infiniteScroll')

    $link = $(link)
    if (url = $link.find('a').attr('href'))
      $(window).on 'scroll.infiniteScroll', => @loadNextPage($link)
      $(window).scroll()

  @loadNextPage: ($link) ->
    if ($(window).scrollTop() > $link.offset().top - $(window).height() - 500)
      $(window).off('scroll.infiniteScroll')
      $.rails.disableElement($link.find('a'))
      $.getScript($link.find('a').attr('href'))

$.fn.infiniteScroll = () ->
  Spina.InfiniteScroll.init(this)

$(document).on 'page:change', ->
  $(window).off('scroll.infiniteScroll')
