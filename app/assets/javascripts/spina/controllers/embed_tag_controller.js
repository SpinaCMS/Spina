import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  connect() {
    let event = new CustomEvent("embed-tag:embedded", this.eventOptions)
    this.element.dispatchEvent(event)
  }
  
  get eventOptions() {
    let clone = this.element.cloneNode(true)
    clone.removeAttribute("data-controller")
    return {bubbles: true, detail: {html: clone.outerHTML}}
  }
  
}