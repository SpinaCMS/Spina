(() => {
  const application = Stimulus.Application.start()

  application.register("image-form", class extends Stimulus.Controller {
    static get targets() {
      return ["image", "imageId", "signedBlobId", "filename"]
    }

    remove(e) {
      // Prevent link
      e.preventDefault()
      e.stopPropagation()

      // Remove image and reset field
      this.imageTarget.querySelectorAll('img').forEach(image => image.remove())
      this.imageIdTarget.value = null
      this.signedBlobIdTarget.value = null
      this.filenameTarget.value = null
    }
    
  })
})()
