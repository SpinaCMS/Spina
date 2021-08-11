import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["pane", "button"]
  }

  connect() {
    this.element[this.identifier] = this

    this.hideAllPanes()
    this.deactiveAllButtons()

    let firstButton = this.buttonTargets[0]
    if (firstButton) {
      let firstPane = document.getElementById(firstButton.dataset.paneId)
      this.activateButton(firstButton)
      firstPane.hidden = false
    }
  }

  added(event) {
    let button = event.target
    let pane = document.getElementById(button.dataset.paneId)

    this.hideAllPanes()
    this.deactiveAllButtons()

    this.activateButton(button)
    pane.hidden = false
  }

  show(event) {
    let activeButton = event.currentTarget
    let activePane = document.getElementById(activeButton.dataset.paneId)

    // Deactivate
    this.deactiveAllButtons()
    this.hideAllPanes()

    // Activate
    this.activateButton(activeButton)
    activePane.hidden = false
  }

  activateButton(button) {
    button.classList.add(...this.activeClasses)
    button.classList.remove(...this.inactiveClasses)
  }

  deactiveAllButtons() {
    this.buttonTargets.forEach(function(button) {
      button.classList.remove(...this.activeClasses)
      button.classList.add(...this.inactiveClasses)
    }.bind(this))
  }

  hideAllPanes() {
    this.paneTargets.forEach((pane) => pane.hidden = true)
  }

  get activeClasses() {
    return (this.element.dataset.tabsActive || "active").split(" ")
  }

  get inactiveClasses() {
    return (this.element.dataset.tabsInactive || "inactive").split(" ")
  }

}