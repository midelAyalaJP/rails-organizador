import { Application } from "@hotwired/stimulus"

const application = Application.start()

import jQuery from "jquery"

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.jQuery = jQuery
window.$ = jQuery

export { application }
