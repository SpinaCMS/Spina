import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "button", "container" ]
  }

  connect() {
    this.scrollElement.addEventListener("scroll", this.load.bind(this))
    this.load() // Initial load
  }

  disconnect() {
    this.scrollElement.removeEventListener("scroll", this.load.bind(this))
  }
  
  load() {
    if (this.hasButtonTarget) {
      let top = this.buttonTarget.getBoundingClientRect().top
      if (top < window.innerHeight + 500) {
        this.buttonTarget.click()
        this.buttonTarget.remove()
      }
    }
  }
  
  get scrollElement() {
    if (this.hasContainerTarget) {
      return this.containerTarget
    } else {
      return document.getElementById("main")
    }
  }

}