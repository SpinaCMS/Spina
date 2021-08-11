import { Controller } from "@hotwired/stimulus"
import Sortable from "libraries/sortablejs"
import formRequestSubmitPolyfill from "libraries/form-request-submit-polyfill"

export default class extends Controller {
  static get targets() {
    return [ "form", "list" ]
  }

  connect() {
    this.sortable = Sortable.create(this.listTarget, {
      handle: '[data-sortable-handle]',
      onEnd: this.saveSort.bind(this),
      animation: 150
    })
  }

  saveSort(event) {
    if (this.hasFormTarget) {
      this.prepareForm()
      this.formTarget.requestSubmit()
    }
  }
  
  prepareForm() {
    // Empty form
    this.formTarget.innerHTML = ''
    
    // Add hidden fields to store ids
    this.orderedIds.forEach(function(id) {
      this.formTarget.insertAdjacentHTML("beforeend", `<input type="hidden" name="ids[]" value="${id}" />`)
    }.bind(this))
  }

  get orderedIds() {
    return this.sortable.toArray()
  }

}