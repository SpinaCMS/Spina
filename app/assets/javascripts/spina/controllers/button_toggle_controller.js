import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "button",
    "circle",
    "showOnTrue",
    "showOnFalse",
    "toggleValue",
    "colorClass"
  ]

  toggle() {
    this.toggleValueTarget.value = !(this.toggleValueTarget.value === "true")

    if (this.toggleValueTarget.value === "true") {
      this.toggleOn();
      this.showOnTrue();
    }
    else {
      this.toggleOff();
      this.showOnFalse();
    }
  }

  toggleOn() {
    debugger
    this.buttonTarget.classList.remove("!bg-gray-200")
    this.buttonTarget.classList.add(this.colorClassTarget.dataset.colorClass)

    this.circleTarget.classList.add("translate-x-5")
    this.circleTarget.classList.remove("translate-x-0")
  }
  
  toggleOff() {
    this.buttonTarget.classList.add("!bg-gray-200")
    this.buttonTarget.classList.remove(this.colorClassTarget.dataset.colorClass)

    this.circleTarget.classList.remove("translate-x-5")
    this.circleTarget.classList.add("translate-x-0")
  }

  showOnTrue() {
    this.showOnTrueTargets.forEach(element => { element.hidden = false });
    this.showOnFalseTargets.forEach(element => { element.hidden = true });
  }

  showOnFalse() {
    this.showOnTrueTargets.forEach(element => { element.hidden = true });
    this.showOnFalseTargets.forEach(element => { element.hidden = false });
  }
}
