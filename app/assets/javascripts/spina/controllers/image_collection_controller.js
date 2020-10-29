import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  static get targets() {
    return [ "collection", "fields" ]
  }
  
  connect() {
    this.sortable = Sortable.create(this.collectionTarget, {
      animation: 150
    })
  }
  
  removeImage(event) {
    let id = event.currentTarget.dataset.id
    let image = document.getElementById(id)
    image.parentElement.removeChild(image)
  }
  
  handleDone(event) {
    let childIndex = this.element.dataset.childIndex
    let fields = this.element.dataset.fields

    // Get timestamp
    let time = new Date().getTime()
    let regex = new RegExp(childIndex, 'g')
    let html = fields.replace(regex, time)
    
    let range = document.createRange()
    range.selectNodeContents(document.body)
    let fragment = range.createContextualFragment(html)
    
    fragment.querySelector(`[data-media-picker-target="signedBlobId"]`).value = event.detail.signedBlobId
    fragment.querySelector(`[data-media-picker-target="filename"]`).value = event.detail.filename
    fragment.querySelector(`[data-media-picker-target="imageId"]`).value = event.detail.imageId
    fragment.querySelector('img').src = event.detail.thumbnail

    // Insert fields
    this.collectionTarget.appendChild(fragment)
  }
  
}