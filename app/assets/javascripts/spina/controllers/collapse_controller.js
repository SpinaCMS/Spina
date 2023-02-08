import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static targets = [ "container", "placeholder", "icon" ]
  
  toggle() {
    if (this.collapsed) {
      this.containerTarget.removeAttribute("hidden")
      this.placeholderTarget.hidden = true
      this.iconTarget.classList.add("rotate-90")
    } else {
      this.containerTarget.hidden = true
      this.placeholderTarget.removeAttribute("hidden")
      this.iconTarget.classList.remove("rotate-90")
    }
  }
  
  get collapsed() {
    return this.containerTarget.hidden
  }
  
}