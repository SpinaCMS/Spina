import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = [ "container", "placeholder", "icon" ]
  
  toggle(event) {
    if (this.collapsed) {
      this.containerTarget.removeAttribute("hidden")
      this.placeholderTarget.hidden = true
      this.iconTarget.classList.add("rotate-90")
      this.element.removeAttribute("data-collapsed")
    } else {
      this.containerTarget.hidden = true
      this.placeholderTarget.removeAttribute("hidden")
      this.iconTarget.classList.remove("rotate-90")
      this.element.dataset.collapsed = true
      event.preventDefault()
    }
  }
  
  get collapsed() {
    return this.element.hasAttribute("data-collapsed")
  }
  
}