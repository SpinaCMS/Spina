(() => {
  const application = Stimulus.Application.start()

  application.register("media-picker", class extends Stimulus.Controller {
    static get targets() {
      return ["input", "image", "grid", "selectedImage", "selectedImages", "selectedCount", "alt", "linkToUrl", "trixImage"]
    }

    connect() {
      this.toggleActive()

      if (this.hasSelectedImagesTarget) {
        this.sortable = Sortable.create(this.selectedImagesTarget)
      }
    }

    choose(event) {
      switch(this.element.dataset.mode) {
        case "single":
          this.imageTargets.forEach((image) => image.querySelector('input').checked = false)
          event.currentTarget.checked = true
          this.hiddenInput.value = event.currentTarget.value
          this.placeholder.innerHTML = `<img src="${event.currentTarget.dataset.thumbnailUrl}" width="200" height="150" />`
          this.element.modal.close()
          break
        case "multiple":
          if(event.currentTarget.checked) {
            this.addImage(event.currentTarget.dataset.imageId, event.currentTarget.dataset.thumbnailUrl)
          } else {
            this.removeImage(event.currentTarget.dataset.imageId)
          }
          this.setCount()
          break
        case "trix":
          this.imageTargets.forEach((image) => image.querySelector('input').checked = false)
          event.currentTarget.checked = true
          this.trixImage = event.currentTarget
          break
      }
    }

    choose_multiple(event) {
      // Set image id's
      this.hiddenInput.value = this.selectedIds.join(',')

      // Set image thumbnails
      this.placeholder.innerHTML = ""
      this.selectedImageTargets.forEach(function(image) {
        this.placeholder.insertAdjacentHTML("beforeend", `<img src="${image.src}" />`)
      }.bind(this))

      // Close modal
      this.element.modal.close()
    }

    insert_trix(event) {
      let customEvent = new CustomEvent("image-insert", {bubbles: true, cancelable: true, detail: {
        url: this.trixImage.dataset.fullImageUrl, 
        alt: this.altTarget.value, 
        link_to_url: this.linkToUrlTarget.value
      }})
      this.trixEditor.dispatchEvent(customEvent)

      // Close modal
      this.element.modal.close()
    }

    refresh() {
      // fetch('/admin/media_picker')
      //   .then(response => response.text())
      //   .then(function(html) {
      //     this.gridTarget.innerHTML = html
      //     this.toggleActive()
      //   }.bind(this))
    }

    toggleActive() {
      this.imageTargets.forEach(function(image) {
        let input = image.querySelector('input')
        if (this.selectedIds.includes(input.value)) input.checked = true
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

    get trixEditor() {
      return document.querySelector(`trix-editor[toolbar="${this.inputTarget.value}"]`)
    }

    get selectedIds() {
      return this.selectedImageTargets.map(function(image) {
        return image.dataset.imageId
      })
    }

    get hiddenInput() {
      return document.querySelector(`#${this.inputTarget.value}`)
    }

    get placeholder() {
      return document.querySelector(`#${this.inputTarget.value}`).nextElementSibling
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }

  })
})()