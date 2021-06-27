import { Controller } from "stimulus"
import hotkeys from "hotkeys"

export default class extends Controller {
  static get targets() {
    return [ "button" ]
  }
  
  connect() {
    hotkeys(this.element.dataset.hotkeys, this.handleHotkeys.bind(this))
  }
  
  handleHotkeys(event, handler) {
    event.preventDefault()
    
    if (this.hasButtonTarget) {
      this.buttonTarget.click()
    }
  }
  
}