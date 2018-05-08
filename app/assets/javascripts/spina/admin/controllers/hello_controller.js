(() => {
  const application = Stimulus.Application.start()

  application.register("hello", class extends Stimulus.Controller {

    connect() {
      console.log("Hello!")
    }
    
  })
})()