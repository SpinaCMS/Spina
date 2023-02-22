import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "children", "indicator" ]
  
  toggle(event) {
    this.childrenTarget.toggleAttribute("hidden")
    this.indicatorTarget.classList.toggle("rotate-90")
    
    if (this.collapsed) event.preventDefault()
  }
  
  get collapsed() {
    return this.childrenTarget.hidden
  }
  
}