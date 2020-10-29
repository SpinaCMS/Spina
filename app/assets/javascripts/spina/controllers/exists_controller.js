import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    const event = document.createEvent("CustomEvent")
    event.initCustomEvent("exists", true, true, null)
    this.element.dispatchEvent(event)
  }

}