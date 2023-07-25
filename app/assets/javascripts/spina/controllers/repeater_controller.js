import { Controller } from "@hotwired/stimulus"
import Sortable from "libraries/sortablejs"

export default class extends Controller {
  static get targets() {
    return [ "list", "listItem", "content" ]
  }

  connect() {
    this.sortable = Sortable.create(this.listTarget, {
      handle: 'button svg',
      dataIdAttr: "data-pane-id",
      onEnd: this.sort.bind(this),
      animation: 150
    })
  }

  sort(event) {
    let ids = this.sortable.toArray()

    // Sort the DOM elements containing the repeater fields
    this.panes
      .sort((a, b) => ids.indexOf(a.id) - ids.indexOf(b.id))
      .map((node, index) => {
        this.contentTarget.appendChild(node)
        const positionField = node.querySelector('[data-position]')
        if (positionField) positionField.value = index
      })

  }

  addFields(event) {
    let button = event.currentTarget
    let childIndex = button.dataset.childIndex

    // Get timestamp
    let time = new Date().getTime()
    let regex = new RegExp(childIndex, 'g')
    let html = button.dataset.fields.replace(regex, time)

    // Insert button
    this.listTarget.insertAdjacentHTML('beforeend', this.buttonHTML(time))
    // Insert fields
    const parser = new DOMParser();
    const docFields = parser.parseFromString(html, 'text/html');
    this.contentTarget.appendChild(docFields.body.firstChild);

  }

  removeFields(event) {
    let id = event.currentTarget.dataset.id
    let listItem = this.listItemTargets.find(listItem => listItem.dataset.paneId == id)
    let sibling = listItem.previousElementSibling || listItem.nextElementSibling
    let pane = document.getElementById(id)
    this.listTarget.removeChild(listItem)
    this.contentTarget.removeChild(pane)
    
    // Activate previous/next tab
    if(sibling) sibling.click()
  }

  buttonHTML(pane_id) {
    return `<button type="button" class="text-gray-600 rounded-md px-3 truncate text-sm font-medium flex items-center w-full h-10" data-controller="exists" data-action="tabs#show" data-tabs-target="button" data-repeater-target="listItem" data-pane-id="pane_${pane_id}">
      <svg class="w-4 h-4 mr-2" fill="currentColor" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"><path d="M432 288H16c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h416c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16zm0-112H16c-8.8 0-16 7.2-16 16v16c0 8.8 7.2 16 16 16h416c8.8 0 16-7.2 16-16v-16c0-8.8-7.2-16-16-16z"/></svg>
      ...
    </button>`
  }

  get panes() {
    return [...this.contentTarget.children]
  }

}