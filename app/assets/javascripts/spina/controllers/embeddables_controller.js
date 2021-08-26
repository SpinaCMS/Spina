import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "html" ]
  }
  
  embed(event) {
    this.trixEditor.insertComponent(this.htmlTarget.innerHTML)
  }
  
  get trixEditor() {
    return document.getElementById(this.element.dataset.trixTarget).trix
  }
  
}