import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return ["pane", "button"]
  }

  connect() {
    this.element[this.identifier] = this

    // ADDITION
    // When a form has errors on a hidden pane, the user can't see the error
    // Since multiple panes can have fields with errors, the easiest thing to do is show all panes
    // GLOBAL IMPLEMENTATION: Will need to add `data-has-errors`` attribute to all admin-scoped forms that have tabs, e.g.:
    // <%= form_with model: @page, url: spina.admin_page_path(@page), id: dom_id(@page), data: { 'has-errors': @page.errors.any? } do |f| %>
    //    (because only the form is reloaded via Turbo, not the whole DOM, this can't be a Stimulus value on the controller div. The controller div isn't reloaded on form submission, so the `data-has-errors` value persists even when the object no longer has any errors)
    if (document.forms[0].attributes['data-has-errors'].value == 'true') {
      this.showAllPanes()
    } else {
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

  // ADDITION
  showAllPanes() {
    this.paneTargets.forEach((pane) => pane.hidden = false)
  }

  get activeClasses() {
    return (this.element.dataset.tabsActive || "active").split(" ")
  }

  get inactiveClasses() {
    return (this.element.dataset.tabsInactive || "inactive").split(" ")
  }

}
