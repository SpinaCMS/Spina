(() => {
  const application = Stimulus.Application.start()

  application.register("attachment-picker", class extends Stimulus.Controller {
    static get targets() {
      return ["signedBlobId"]
    }

    chooseAttachment(event) {
      let option = event.currentTarget.options[event.currentTarget.selectedIndex]
      this.signedBlobIdTarget.value = option.dataset.signedBlobId || ""
    }
  })
})()