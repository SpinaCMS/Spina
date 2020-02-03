(() => {
  const application = Stimulus.Application.start()

  application.register("image-form", class extends Stimulus.Controller {
    static get targets() {
      return ["image", "field", "removeButton"]
    }

    remove(e) {
      // Prevent link
      e.preventDefault()
      e.stopPropagation()

      // Remove image and reset field
      this.imageTarget.querySelector('img').remove()
      this.removeButtonTarget.style.display = "none"
      this.fieldTarget.value = null
    }
    
  })
})()
