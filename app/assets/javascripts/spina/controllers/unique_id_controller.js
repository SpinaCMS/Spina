import { Controller } from "stimulus"

export default class extends Controller {
  
  connect() {
    this.replaceHTML()
  }
  
  replaceHTML() {
    let html = this.element.innerHTML
    
    let uuid = this.generateUUID()
    let regex = new RegExp(this.id, 'g')
    let replaced_html = html.replace(regex, uuid)
    
    this.element.innerHTML = replaced_html
    this.element.id = uuid
  }
  
  generateUUID() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8)
      return v.toString(16)
    })
  }
  
  get id() {
    return this.element.dataset.uniqueId
  }
  
}