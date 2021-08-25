import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "html" ]
  }
  
  embed(event) {
    // let [data, status, xhr] = event.detail
    // const { detail: [, , xhr] } = event    
    this.trixEditor.insertComponent(this.htmlTarget.innerHTML)
  }
  
  get trixEditor() {
    return document.getElementById(this.element.dataset.trixTarget).trix
  }
  
}