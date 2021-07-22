import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    if (!this.loaded) {
      this.element.classList.add('transition-opacity', 'duration-500', 'opacity-0')
      this.element.addEventListener("load", this.fadeIn.bind(this))
    }
  }

  fadeIn() {
    this.element.classList.remove('opacity-0')
  }
  
  get loaded() {
    return this.element.complete && this.element.naturalHeight !== 0
  }

}