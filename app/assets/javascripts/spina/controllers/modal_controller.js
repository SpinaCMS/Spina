import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.element[this.identifier] = this
  }

  close() {
    this.element.remove()
  }
  
  escClose(event) {
    if (event.key === 'Escape') this.close()
  }

}