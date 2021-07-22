import { Controller } from "stimulus"
import formRequestSubmitPolyfill from 'form-request-submit-polyfill'

export default class extends Controller {
  
  requestSubmit() {
    this.element.requestSubmit()
  }
  
}