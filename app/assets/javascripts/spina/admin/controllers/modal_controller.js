(() => {
  const application = Stimulus.Application.start()

  application.register("modal", class extends Stimulus.Controller {
    static get targets() {
      return []
    }

    connect() {
      this.element[this.identifier] = this
    }

    close() {
      document.querySelector('body').removeChild(this.element)
    }

  })
})()