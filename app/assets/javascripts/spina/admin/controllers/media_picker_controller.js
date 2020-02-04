(() => {
  const application = Stimulus.Application.start()

  application.register("media-picker", class extends Stimulus.Controller {
    static get targets() {
      return ["selector", "placeholder"]
    }

    choose(event) {
      // Set image ID
      this.hiddenInput.value = event.currentTarget.value

      // Set image URL
      this.placeholder.innerHTML = `<img src="${event.currentTarget.dataset.thumbnailUrl}" width="200" height="150" />`
    }

    get hiddenInput() {
      return document.querySelector(`#${this.selectorTarget.value}`)
    }

    get placeholder() {
      return document.querySelector(`#${this.placeholderTarget.value}`)
    }

  })
})()