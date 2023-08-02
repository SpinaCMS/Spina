import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    // Gets triggered when refreshed by the ImagesController, and will process any images here
    this.insertImages()
  }

  insertImages() {
    const imagesMetadata = this.element.querySelectorAll('div.trix-insert-image')
    imagesMetadata.forEach(tag => {
      const imageData = this.#imageData(tag)
      let insertImageEvent = new CustomEvent("media-picker:done", {detail: imageData})
      const targetEditor = document.getElementById(this.trixTargetId)
      this.trixTarget.dispatchEvent(insertImageEvent)
    })
  }

  get trixTarget() {
    return document.getElementById(this.trixTargetId)
  }

  get trixTargetId() {
    return this.element.dataset.trixTargetId
  }

  #imageData(imageMeta) {
    return {
      filename: imageMeta.dataset.filename,
      signedBlobId: imageMeta.dataset.signedBlobId,
      imageId: imageMeta.dataset.imageId,
      embeddedUrl: imageMeta.dataset.embeddedUrl,
      thumbnail: imageMeta.dataset.thumbnail,
      originalUrl: imageMeta.dataset.originalUrl
    }
  }

}
