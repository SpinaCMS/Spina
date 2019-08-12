(() => {
  const application = Stimulus.Application.start()

  application.register("gallery-select", class extends Stimulus.Controller {
    static get targets() {
      return ["singleImage", "multipleImages", "multiple", "counter"]
    }

    select(event) {
      let item = event.currentTarget
      let imageId = item.dataset.imageId
      if (this.multipleTarget.checked) {
        item.classList.toggle('selected')
        if (item.classList.contains('selected')) {
          this.addToMultipleImages(imageId)  
        } else {
          this.removeFromMultipleImages(imageId)
        }
        this.counterTarget.innerText = `(${this.imageCount})`
      } else {
        item.parentElement.querySelectorAll('.item').forEach(function(item) {
          item.classList.remove('selected')
        })
        item.classList.add('selected')
        this.singleImageTarget.value = imageId
      }
    }

    addToMultipleImages(imageId) {
      let imageIds = this.multipleImages
      imageIds.push(imageId)
      this.multipleImagesTarget.value = [...new Set(imageIds)].join("-")
    }

    removeFromMultipleImages(imageId) {
      let imageIds = this.multipleImages
      let newImageIds = imageIds.filter(function(id) {
        return id != imageId
      })
      this.multipleImagesTarget.value = newImageIds.join("-")
    }

    get multipleImages() {
      return this.multipleImagesTarget.value.split("-")
    }

    get imageCount() {
      return this.multipleImages.length
    }
    
  })
})()
