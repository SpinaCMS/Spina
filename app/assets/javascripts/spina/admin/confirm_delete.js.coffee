$.rails.allowAction = (element) ->

  message = element.data('confirm')
  return true unless message

  $link = element.clone().removeAttr('data-confirm').removeAttr('data-icon').removeAttr('class')
  $link.addClass('primary')
  $link.html("<i data-icon=\"j\"></i> Ja, dat weet ik zeker")

  modal_html = """
              <div id="modal" class="modal"><header class="big-header">
                <a href="#" class="close_modal" data-dismiss="modal"><i class="icon-only" data-icon="m"></i></a>
                <h3>#{message}</h3>
              </header>

              <footer>
                <a href="#" data-dismiss="modal">Nee, annuleren</a>
              </footer></div>
               """

  $(modal_html).modal()
  $('#modal footer').append($link)

  return false