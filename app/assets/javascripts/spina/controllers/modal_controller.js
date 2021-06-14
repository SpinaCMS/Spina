import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element[this.identifier] = this
  }

  close() {
    this.element.remove()
    this.resetTurboFrame() // Bugfix
  }
  
  escClose(event) {
    if (event.key === 'Escape') this.close()
  }
  
  // Reset Turbo Frame
  // This is a bugfix for a bug introduced in turbo 7.0.0-beta.6
  // https://github.com/hotwired/turbo/issues/249
  resetTurboFrame() {
    this.modalTurboFrame.src = ""
  }
  
  get modalTurboFrame() {
    return document.querySelector(`turbo-frame[id="modal"]`)
  }

}