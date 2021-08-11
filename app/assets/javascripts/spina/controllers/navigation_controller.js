import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["primary", "button", "navigation", "label"]
  }
  
  connect() {
    if (window.innerWidth < 768) {
      this.closeAllNavigations()
    }
  }

  toggleNavigation(navigation) {
    let ul = navigation.querySelector("ul")
    if (ul.classList.contains("translate-x-full")) { 
      this.primaryTarget.classList.add("md:bg-opacity-50")
      this.labelTargets.forEach(function(label) {
        label.classList.add("-translate-x-2")
        this.switchClass(label, 'opacity-100', 'opacity-0')
      }.bind(this))
      this.switchClass(navigation.querySelector("ul"), "translate-x-full", "md:translate-x-20")
    } else {
      this.primaryTarget.classList.remove("md:bg-opacity-50")
      this.labelTargets.forEach(function(label) {
        label.classList.remove("-translate-x-2")
        this.switchClass(label, 'opacity-0', 'opacity-100')
      }.bind(this))
      this.switchClass(navigation.querySelector("ul"), "md:translate-x-20", "translate-x-full")
    }
  }

  toggle(event) {
    let button = event.currentTarget
    let closed = button.nextElementSibling.classList.contains("translate-x-full")
    this.closeAllNavigations()

    // If button was closed, open the nav
    if (closed) {
      this.switchClass(button, "opacity-50", "opacity-100")
      this.toggleNavigation(button.parentElement)
    }
  }

  closeAllNavigations() {
    this.buttonTargets.forEach(function(button) {
      this.switchClass(button, "opacity-100", "opacity-50")
    }.bind(this))
    
    this.backToFirstLevel()
  }
  
  backToFirstLevel() {
    this.navigationTargets.forEach(function(navigation) {
      this.switchClass(navigation.querySelector("ul"), "md:translate-x-20", "translate-x-full")
    }.bind(this))
    this.primaryTarget.classList.remove("md:bg-opacity-50")
    this.labelTargets.forEach(function(label) {
      label.classList.remove("-translate-x-2")
      this.switchClass(label, 'opacity-0', 'opacity-100')
    }.bind(this))
  }

  switchClass(element, from_class, to_class) {
    element.classList.remove(from_class)
    element.classList.add(to_class)
  }

  get activeItem() {
    return this.element.querySelector("[data-navigation-active]")
  }

  get activeNavigation() {
    return this.activeItem.closest(`[data-navigation-target*="navigation"]`)
  }

}