import { Controller } from "stimulus"

export default class extends Controller {
	
	connect() {
		this.element[this.identifier] = this
	}
	
	doneLoading() {
		// this.element.disabled = false
		this.element.style.width = 'auto'
		this.element.innerHTML = this.originalHTML
	}
	
	loading() {
		// this.element.disabled = true
		this.element.style.width = `${this.element.offsetWidth}px`
		this.originalHTML = this.element.innerHTML // Store original HTML
		
		this.element.innerHTML = `
			<svg class="animate-spin -ml-1 mr-2 h-4 w-4" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
				<circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
				<path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
			</svg>
			${this.element.dataset.loadingMessage}
		`
	}
	
	get originalHTML() {
		return this.original_html
	}
	
	set originalHTML(html) {
		this.original_html = html
	}
	
}