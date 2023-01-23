import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  
  static get targets() {
    return ['input', 'label', 'search']
  }
  
  select(event) {
    let button = event.currentTarget
    
    this.inputTarget.value = button.dataset.id
    this.labelTarget.innerText = button.dataset.title
  }
  
  autofocus() {
    setTimeout(function() {
      this.searchTarget.focus()
    }.bind(this), 100)
  }
  
}