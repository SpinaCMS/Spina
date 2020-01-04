(() => {
  const application = Stimulus.Application.start()

  application.register("image-form", class extends Stimulus.Controller {
    static get targets() {
      return ["image", "field", "button"]
    }

    remove(e) {
      // Prevent link
      e.preventDefault()
      e.stopPropagation()

      // Remove image and reset field
      this.imageTarget.remove()
      this.buttonTarget.remove()
      this.fieldTarget.value = null
    }
    
  })
})()
