import { application } from "controllers/application"

// Eager load all Stimulus controllers
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
