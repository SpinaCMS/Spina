(() => {
  const application = Stimulus.Application.start()

  application.register("modal", class extends Stimulus.Controller {
    static get targets() {
      return []
    }

    connect() {
    }

    close() {
      document.querySelector('body').removeChild(this.element)
    }

  })
})()