import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    this.element.addEventListener('submit', this.confirm.bind(this))
  }

  confirm(event) {
    event.stopPropagation()
    event.preventDefault()
    this.turboFrame.innerHTML = this.modalHTML
  }

  get modalHTML() {
    return `<div class="modal" data-controller="modal shortcuts" data-action="keyup@document->shortcuts#confirmClick keyup@document->modal#escClose">
      <button type="button" class="cursor-default w-full h-full fixed inset-0 bg-gray-700 bg-opacity-25 animate__animated animate__fadeIn animate__faster" tabindex="-1" data-action="modal#close"></button>
      <div class="modal-window animate__animated animate__zoomIn animate__fadeIn animate__faster p-5 max-w-xs">
        <div class="text-center">
          ${this.message}
        </div>
        
        <div class="flex flex-row-reverse mt-3">
        
          ${this.formHTML}
          
          <button class="btn btn-gray mt-2 md:mt-0 md:w-1/2" data-action="modal#close">Cancel</button>
        </div>
      </div>
    </div>`
  }

  get message() {
    return this.element.dataset.confirmMessage
  }
  
  get formHTML() {
    let element = document.createRange().createContextualFragment(this.element.outerHTML)
    let form = element.querySelector('form')
    let button = element.querySelector('input[type="submit"], button[type="submit"]')
    
    form.removeAttribute('data-controller')
    form.dataset.turboFrame = "_top"
    form.dataset.action = "turbo:submit-end->modal#close"
    form.className = "mt-6 md:mt-0 md:w-1/2 md:ml-3"
    button.className = "btn btn-red w-full"
    button.dataset.shortcutsTarget = "confirm"
    button.innerText = "Delete"
    button.value = "Delete"
    
    // Store in temp div
    let div = document.createElement('div')
    div.appendChild(form)

    return div.innerHTML
  }
  
  get turboFrame() {
    return document.querySelector('turbo-frame[id="modal"]')
  }

}