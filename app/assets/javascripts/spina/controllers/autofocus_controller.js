import { Controller } from "stimulus"

export default class extends Controller {
  
  connect() {
    this.element.focus()
  }
  
}