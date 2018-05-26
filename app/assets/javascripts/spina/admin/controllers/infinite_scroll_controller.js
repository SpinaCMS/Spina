(() => {
  const application = Stimulus.Application.start()

  application.register("infinite-scroll", class extends Stimulus.Controller {
    static get targets() {
      return ["link"]
    }

    connect() {
      // Disable scroll event listeners
      $(window).off('scroll.infiniteScroll')
      $('#overlay section').off('scroll.infiniteScroll')

      let $link = $(this.linkTarget)

      // If the link has an actual href
      if ($link.attr('href').length > 0) {
        // If the window scrolls
        $(window).on('scroll.infiniteScroll', this.loadNextPage($link))

        // If the overlay scrolls
        $('#overlay section').on('scroll.infiniteScroll', function() {
          $(window).trigger('scroll.infiniteScroll')
        })

        $(window).trigger('scroll.infiniteScroll')
      }
    }

    loadNextPage(link) {
      if ($(window).scrollTop() > link.offset().top - $(window).height() - 500) {
        $(window).off('scroll.infiniteScroll')
        $('#overlay section').off('scroll.infiniteScroll')
        $.rails.disableElement(link)
        $.getScript(link.attr('href'))
      }
    }
    
  })
})()
