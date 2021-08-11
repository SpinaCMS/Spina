import { Controller } from "@hotwired/stimulus"
import hotkeys from "libraries/hotkeys"

export default class extends Controller {
  static get targets() {
    return [ "button" ]
  }
  
  connect() {
    hotkeys(this.element.dataset.hotkeys, this.handleHotkeys.bind(this))
    hotkeys.filter = (event) => true
  }
  
  handleHotkeys(event, handler) {
    event.preventDefault()
    if (this.hasButtonTarget) {
      this.buttonTarget.click()
    }
  }
  
}