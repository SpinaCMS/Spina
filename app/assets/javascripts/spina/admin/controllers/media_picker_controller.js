(() => {
  const application = Stimulus.Application.start()

  application.register("media-picker", class extends Stimulus.Controller {
    static get targets() {
      return ["selector", "placeholder", "image", "grid", "selectedImage", "selectedImages", "selectedCount"]
    }

    connect() {
      this.toggleActive()
    }

    choose(event) {
      // Set image ID
      this.hiddenInput.value = event.currentTarget.value

      // Set image URL
      this.placeholder.innerHTML = `<img src="${event.currentTarget.dataset.thumbnailUrl}" width="200" height="150" />`
    }

    choose_multiple(event) {
      // Set image id's
      this.hiddenInput.value = this.selectedIds.join(',')

      // Set image thumbnails
      this.placeholder.innerHTML = ""
      this.selectedImageTargets.forEach(function(image) {
        this.placeholder.insertAdjacentHTML("beforeend", `<img src="${image.src}" />`)
      }.bind(this))
    }

    toggleActive() {
      this.imageTargets.forEach(function(image) {
        let input = image.querySelector('input')
        if (this.selectedIds.includes(input.value)) {
          input.checked = true
        }
      }.bind(this))
    }

    openFolder(event) {
      event.preventDefault()
      fetch(event.currentTarget.href)
        .then(response => response.text())
        .then(function(html) {
          this.gridTarget.innerHTML = html
          this.toggleActive()
        }.bind(this))
    }

    toggle(event) {
      if(event.currentTarget.checked) {
        this.addImage(event.currentTarget.dataset.imageId, event.currentTarget.dataset.thumbnailUrl)
      } else {
        this.removeImage(event.currentTarget.dataset.imageId)
      }
      this.setCount()
    }

    setCount() {
      this.selectedCountTarget.innerHTML = `(${this.selectedIds.length})`
    }

    addImage(id, url) {
      this.selectedImagesTarget.insertAdjacentHTML("beforeend", `<img src="${url}" data-image-id="${id}" data-target="media-picker.selectedImage" />`)
    }

    removeImage(id) {
      let image = this.selectedImagesTarget.querySelector(`img[data-image-id="${id}"]`)
      this.selectedImagesTarget.removeChild(image)
    }

    get selectedIds() {
      return this.selectedImageTargets.map(function(image) {
        return image.dataset.imageId
      })
    }

    get hiddenInput() {
      return document.querySelector(`#${this.selectorTarget.value}`)
    }

    get placeholder() {
      return document.querySelector(`#${this.placeholderTarget.value}`)
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }

  })
})()