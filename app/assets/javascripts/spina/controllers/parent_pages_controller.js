import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["frame"]
  }
  
  update(event) {
    let select = event.currentTarget
    let option = select.options[select.selectedIndex]
    let src = option.dataset.parentPagesUrl

    this.frameTarget.src = src
  }
  
}