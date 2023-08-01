import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  start(event) {
    const file = event.detail.file
    if (!file) return

    const trixId = event.detail.trixId
    this.trixTargetId = trixId

    // DataTransfer() avoids the "TypeError: Failed to set the 'files' property on 'HTMLInputElement': Failed to convert
    // value to 'FileList'." error which occurs if you try to directly assign: `this.fileField.files = [file]`
    // https://stackoverflow.com/questions/52078853/is-it-possible-to-update-filelist
    const fileList = new DataTransfer()
    fileList.items.add(file)
    this.fileField.files = fileList.files

    const changeEvent = new Event("input"); // This triggers the upload
    this.fileField.dispatchEvent(changeEvent);
  }

  get fileField() {
    return this.element.querySelector('form input.image-upload-file-field')
  }

  get form() {
    return this.element.querySelector('form')
  }

  get trixTargetId() {
    return this.element.querySelector('form > #trix_target_id').value
  }

  set trixTargetId(value) {
    this.element.querySelector('form > #trix_target_id').value = value
  }

  #imageData(imageMeta) {
    return {
      filename: imageMeta.dataset.filename,
      signedBlobId: imageMeta.dataset.signedBlobId,
      imageId: imageMeta.dataset.imageId,
      embeddedUrl: imageMeta.dataset.embeddedUrl,
      thumbnail: imageMeta.dataset.thumbnail
    }
  }

}
