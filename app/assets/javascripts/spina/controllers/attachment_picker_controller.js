import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "signedBlobId", "filename" ]
  }

  pick(event) {
    let select = event.currentTarget
    let option = select.options[select.selectedIndex]
    this.signedBlobIdTarget.value = option.dataset.signedBlobId || ""
    this.filenameTarget.value = option.dataset.filename || ""
  }
  
}