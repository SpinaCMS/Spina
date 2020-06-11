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
          this.imageIdInput.value = event.currentTarget.value
          this.signedBlobIdInput.value = event.currentTarget.dataset.signedBlobId
          this.filenameInput.value = event.currentTarget.dataset.filename
          this.placeholder.innerHTML = `<img src="${event.currentTarget.dataset.thumbnailUrl}" width="200" height="150" />`
          this.element.modal.close()
          break
        case "multiple":
          if(event.currentTarget.checked) {
            this.addImage(event.currentTarget.dataset.imageId, event.currentTarget.dataset.signedBlobId, event.currentTarget.dataset.filename, event.currentTarget.dataset.thumbnailUrl)
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
      let fields = this.imageCollectionPlaceholder.dataset.fields
      let id = this.imageCollectionPlaceholder.dataset.id

      let timeIndex = 0

      // Set image thumbnails
      this.imageCollectionPlaceholder.innerHTML = ""
      this.selectedImageTargets.forEach(function(image) {
        // this.imageCollectionPlaceholder.insertAdjacentHTML("beforeend", `<img src="${image.src}" />`)

        // Time
        let time = new Date().getTime() + timeIndex
        timeIndex += 1

        // Regexp
        let regexp = new RegExp(`${id}|new_association`, 'g')

        // Document generation
        let doc = document.createRange().createContextualFragment(fields.replace(regexp, time))
        doc.querySelector(".image-id").value = image.dataset.imageId
        doc.querySelector(".signed-blob-id").value = image.dataset.signedBlobId
        doc.querySelector(".filename").value = image.dataset.filename
        doc.querySelector("img").src = image.src

        this.imageCollectionPlaceholder.appendChild(doc)
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

    addImage(id, signed_blob_id, filename, url) {
      this.selectedImagesTarget.insertAdjacentHTML("beforeend", `<img src="${url}" data-image-id="${id}" data-signed-blob-id="${signed_blob_id}" data-filename="${filename}" data-target="media-picker.selectedImage" />`)
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

    get imageCollectionPlaceholder() {
      return document.querySelector(`#${this.inputTarget.value}`)
    }
    
    get hiddenInputs() {
      return document.querySelector(`#${this.inputTarget.value}`)
    }
    
    get imageIdInput() {
      return this.hiddenInputs.querySelector("input[data-target='image-form.imageId']")
    }

    get signedBlobIdInput() {
      return this.hiddenInputs.querySelector("input[data-target='image-form.signedBlobId']")
    }

    get filenameInput() {
      return this.hiddenInputs.querySelector("input[data-target='image-form.filename']")
    }

    get placeholder() {
      return this.hiddenInputs.nextElementSibling
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }

  })
})()