import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ['input', 'label', 'search']
  }

  connect() {
    // Show placeholder if there is no page selected yet
    if (this.labelTarget.querySelector("turbo-frame") == undefined) {
      this.clear()
    }
  }

  select(event) {
    let button = event.currentTarget

    this.inputTarget.value = button.dataset.id
    this.labelTarget.innerText = button.dataset.title
    this._dispatchChange()
  }

  clear() {
    this.inputTarget.value = ""
    this.labelTarget.innerHTML = `
      <span class="text-gray-400">
        ${this.element.dataset.placeholder}
      </span>
    `
    this._dispatchChange()
  }

  autofocus() {
    setTimeout(function () {
      this.searchTarget.focus()
    }.bind(this), 100)
  }

  _dispatchChange() {
    this.inputTarget.dispatchEvent(new Event('change', { bubbles: true, cancelable: false }))
  }

}
