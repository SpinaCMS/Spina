import { Controller } from "@hotwired/stimulus"
import formRequestSubmitPolyfill from "libraries/form-request-submit-polyfill"

export default class extends Controller {
  
  requestSubmit() {
    this.element.requestSubmit()
  }
  
}