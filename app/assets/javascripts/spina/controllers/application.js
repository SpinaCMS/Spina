import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus
application.warnings = true
application.debug = false
window.Stimulus = application

export { application }

