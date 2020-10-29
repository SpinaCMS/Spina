import { Controller } from "stimulus"

export default class extends Controller {
  static get targets() {
    return [ "item" ]
  }
  
  select(event) {
    let item = event.currentTarget.closest(`[data-selectable-target*="item"]`)
    
    // Deactivate other items
    this.itemTargets.forEach(function(item) {
      this.deactivate(item)
    }.bind(this))

    this.activate(item)
  }
  
  activate(item) {
    this.toggleClasses(item, true)
  }
  
  deactivate(item) {
    this.toggleClasses(item, false)
  }
  
  toggleClasses(item, force) {
    item.querySelectorAll(`[data-selected-class]`).forEach(function(element) {
      let selectedClasses = element.dataset.selectedClass
      if(selectedClasses) {
        selectedClasses.split(" ").forEach(function(cssClass) {
          element.classList.toggle(cssClass, force)
        })
      }
      
      let deselectedClasses = element.dataset.deselectedClass
      if(deselectedClasses) {
        deselectedClasses.split(" ").forEach(function(cssClass) {
          element.classList.toggle(cssClass, !force)
        }) 
      }
    })
  }
}