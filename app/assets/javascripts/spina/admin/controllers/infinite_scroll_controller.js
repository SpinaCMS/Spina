(() => {
  const application = Stimulus.Application.start()

  application.register("infinite-scroll", class extends Stimulus.Controller {
    static get targets() {
      return ["link", "scrollContainer"]
    }

    connect() {
      this.element["infiniteScroll"] = this
      this.scrollElement.addEventListener("scroll", this.loadNextPage.bind(this))
      this.loadNextPage()
    }

    disconnect() {
      this.scrollElement.removeEventListener("scroll", this.loadNextPage.bind(this))
    }

    get scrollElement() {
      if (this.hasScrollContainerTarget) {
        return this.scrollContainerTarget
      } else {
        return window
      }
    }

    loadNextPage() {
      if (this.hasLinkTarget) {
        let top = this.linkTarget.getBoundingClientRect().top
        if (top < window.innerHeight + 500) {
          this.linkTarget.dataset.disableWith = "..."
          this.linkTarget.click()
        }
      }
    }

  })
})()
