import { Controller } from "stimulus"

export default class extends Controller {
  
  connect() {
    this.update()
  }
  
  update() {
    if (this.hasValue) {
      this.element.classList.remove('text-gray-400')
      this.element.classList.add('text-gray-700')
    } else {
      this.element.classList.add('text-gray-400')
      this.element.classList.remove('text-gray-700')  
    }
  }
  
  get hasValue() {
    return this.value.length > 0
  }
  
  get value() {
    return this.element.value
  }
  
}