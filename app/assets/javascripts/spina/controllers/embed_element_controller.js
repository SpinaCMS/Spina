import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect() {
    let event = new CustomEvent("embeddables:embedded", {bubbles: true, detail: this.eventDetail})
    this.element.dispatchEvent(event)
  }
  
  get eventDetail() {
    let clone = this.element.cloneNode(true)
    clone.removeAttribute("data-controller")
    return {html: clone.outerHTML}
  }
  
}