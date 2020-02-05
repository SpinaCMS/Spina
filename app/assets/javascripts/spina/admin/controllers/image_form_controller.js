(() => {
  const application = Stimulus.Application.start()

  application.register("image-form", class extends Stimulus.Controller {
    static get targets() {
      return ["image", "field"]
    }

    remove(e) {
      // Prevent link
      e.preventDefault()
      e.stopPropagation()

      // Remove image and reset field
      this.imageTarget.querySelectorAll('img').forEach(image => image.remove())
      this.fieldTarget.value = null
    }
    
  })
})()
