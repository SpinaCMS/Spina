import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "html" ]
  }
  
  insertEmbeddable(event) {
    this.trixEditor.insertEmbeddable(event.detail.html)
  }
  
  get trixEditor() {
    return document.getElementById(this.element.dataset.trixTarget).trix
  }
  
}