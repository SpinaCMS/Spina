import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "knob", "container", "checkbox" ]
  }

  connect() {
    this.renderKnob()
  }

  toggle() {
    this.checkboxTarget.checked = !this.checked
    this.renderKnob()
  }

  renderKnob() {
    this.containerTarget.classList.toggle('bg-gray-200', !this.checked)
    this.containerTarget.classList.toggle('bg-green-500', this.checked)
    this.knobTarget.classList.toggle('translate-x-6', this.checked)
  }

  get checked() {
    return this.checkboxTarget.checked
  }

}