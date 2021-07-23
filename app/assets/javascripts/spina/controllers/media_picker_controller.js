import { Controller } from "stimulus"

export default class extends Controller {
  static get targets() {
    return [ "filename", "signedBlobId", "imageId", "alt", "thumbnail", "clearButton" ]
  }

  connect() {
    // Hide thumbnail if there's no image
    if (this.hasThumbnailTarget && this.thumbnailTarget.children.length == 0) this.hideThumbnail()
  }

  removeImage() {
    this.imageIdTarget.value = ""
    if (this.hasFilenameTarget) this.filenameTarget.value = ""
    if (this.hasSignedBlobIdTarget) this.signedBlobIdTarget.value = ""
    if (this.hasAltTarget) this.altTarget.value = ""
    this.hideThumbnail()
  }
  
  handleDone(event) {
    // Set fields
    if (this.hasFilenameTarget) this.filenameTarget.value = event.detail.filename
    if (this.hasSignedBlobIdTarget) this.signedBlobIdTarget.value = event.detail.signedBlobId
    this.imageIdTarget.value = event.detail.imageId

    // Set placeholder
    this.setThumbnail(event.detail.thumbnail)
  }
  
  setThumbnail(imageSrc) {
    this.thumbnailTarget.innerHTML = `<img src="${imageSrc}" class="object-contain w-full h-36" />`
    this.showThumbnail()
  }

  showThumbnail() {
    this.thumbnailTarget.classList.remove('hidden')
    this.clearButtonTarget.classList.remove('hidden')
  }

  hideThumbnail() {
    this.thumbnailTarget.classList.add('hidden')
    this.clearButtonTarget.classList.add('hidden')
  }

}