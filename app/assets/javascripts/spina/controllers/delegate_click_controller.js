import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  click() {
    this.targetElement.click()
  }
  
  get targetElement() {
    return document.querySelector(this.element.dataset.delegateClickTarget)
  }
  
}