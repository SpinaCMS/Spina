(() => {
  const application = Stimulus.Application.start()

  application.register("page-collapse", class extends Stimulus.Controller {
    static get targets() {
      return [ "list", "collapseLink", "expandLink" ]
    }

    expand() {
      this.toggleLinks(true)
      
      // Fetch children HTML
      fetch(this.element.dataset.url)
        .then(response => response.text())
        .then(function(html) {
          // Render the list
          this.listTarget.innerHTML = html
        }.bind(this))
    }

    collapse() {
      this.toggleLinks(false)

      // Clear the list
      this.listTarget.innerHTML = ""
    }

    // Toggle plus/minus links
    toggleLinks(expanded) {
      this.expandLinkTarget.style.display = expanded ? "none" : "inline-block"
      this.collapseLinkTarget.style.display = expanded ? "inline-block" : "none"
    }
    
  })
})()
