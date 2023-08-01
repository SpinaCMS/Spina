import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static get targets() {
    return [ "editor", "imageFields", "altField" ]
  }
  
  connect() {
    this.element[this.identifier] = this
    
    this.editorTarget.addEventListener("trix-selection-change", function(event) {
      if (this.mutableImageAttachment) {
        this.imageFieldsTarget.classList.remove("hidden")
        let position = this.mutableImageAttachment.querySelector("img").offsetTop + this.mutableImageAttachment.querySelector("img").offsetHeight
        this.imageFieldsTarget.style.top = `${position}px`
        this.altFieldTarget.value = this.currentAltText
      } else {
        this.imageFieldsTarget.classList.add("hidden")
      }
    }.bind(this))
  }

  insertEmbeddable(html) {
    let embeddable = new Trix.Attachment({
      content: html, 
      contentType: "application/vnd+spina.embed+html"})
      
    this.editor.insertAttachment(embeddable)
  }
  
  preventSubmission(event) {
    if (event.key === 'Enter') event.preventDefault() // Prevent form submit from alt text fields
  }
  
  insertAttachment(event) {
    let attachment = new Trix.Attachment({content: `<span class="trix-attachment-spina-image" data-label="Alt text">
      <img src="${event.detail.embeddedUrl}" />
    </span>`, contentType: "Spina::Image"})
    this.editor.insertAttachment(attachment)
  }

  fileAccept(event) {
    const file = event.file
    if(file) {
      const startUploadEvent = new CustomEvent("auto-file-upload:start", { detail: { file, trixId: this.trixId }})
      window.dispatchEvent(startUploadEvent)
    }
  }

  setAltText(event) {
    let alt = event.currentTarget.value
    let altLabel = alt
    if (altLabel.trim().length == 0) altLabel = "Alt text" // Fallback
    let content = this.trixAttachment.getContent()
    
    // Set span data-alt inside Trix attachment
    this.mutableImageAttachment.firstElementChild.dataset.label = altLabel
    
    // Change content
    let fragment = this.fragmentFromHTML(content)
    fragment.firstElementChild.dataset.label = altLabel
    fragment.querySelector('img').alt = alt
    let div = document.createElement('div')
    div.appendChild(fragment)
    
    this.trixAttachment.setAttributes({content: div.innerHTML})
  }

  preventDefault(event) {
    event.preventDefault()
  }
  
  getTrixAttachment(id) {
    let attachments = this.attachmentManager.getAttachments()
    return attachments.find(attachment => attachment.id == id).attachment
  }
  
  fragmentFromHTML(html) {
    let range = document.createRange()
    range.selectNodeContents(document.body)
    return range.createContextualFragment(html)
  }
  
  get currentAltText() {
    let fragment = this.fragmentFromHTML(this.trixAttachment.getContent())
    return fragment.querySelector('img').alt
  }
  
  get trixAttachment() {
    return this.getTrixAttachment(this.mutableImageAttachment.dataset.trixId)
  }

  get trixId() {
    return this.element.id
  }
  
  get mutableImageAttachment() {
    return this.element.querySelector(`figure[data-trix-mutable][data-trix-content-type="Spina::Image"]`)
  }
  
  get attachmentManager() {
    return this.editorTarget.editorController.attachmentManager
  }
  
  get editor() {
    return this.editorTarget.editor
  }

}