import { Controller } from "stimulus"

export default class extends Controller {
  static get targets() {
    return [ "container" ]
  } 

  toggle() {
    this.containerTarget.classList.toggle('hidden')
  }

}