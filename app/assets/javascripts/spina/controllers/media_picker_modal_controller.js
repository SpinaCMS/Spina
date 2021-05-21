import { Controller } from "stimulus"

export default class extends Controller {
	
	selectImage(event) {
		let image = event.currentTarget
		this.image = image
	}
	
	instantInsert(event) {
		this.confirm(event)	
		this.element.closest('.modal').modal.close()
	}
	
	confirm(event) {
		let imageSelectedEvent = new CustomEvent("media-picker:done", {detail: this.imageData})
		this.target.dispatchEvent(imageSelectedEvent)
	}
	
	get target() {
		return document.getElementById(this.element.dataset.target)
	}
	
	get imageData() {
		return {
			filename: this.image.dataset.filename,
			signedBlobId: this.image.dataset.signedBlobId,
			imageId: this.image.dataset.imageId,
			embeddedUrl: this.image.dataset.embeddedUrl,
			thumbnail: this.image.dataset.thumbnail
		}
	}
	
}