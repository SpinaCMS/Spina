import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "html" ]
  }
  
  catchEmbedded(event) {
    this.trixEditor.insertComponent(event.detail.html)
  }
  
  get trixEditor() {
    return document.getElementById(this.element.dataset.trixTarget).trix
  }
  
}