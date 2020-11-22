(() => {
  const application = Stimulus.Application.start()

  application.register("datetime-picker", class extends StimulusFlatpickr {

  })
})()
