import { Controller } from "stimulus"
import confetti from "canvas-confetti"

export default class extends Controller {
  
  connect() {
    if(this.canvas == undefined) this.createCanvas()
    
    // Create confetti object
    let canvas = this.canvas
    this.confetti = confetti.create(canvas, {resize: true})
    
    // Fire!
    this.fire(0.25, {spread: 26, startVelocity: 55})
    this.fire(0.2, {spread: 60})
    this.fire(0.35, {spread: 100, decay: 0.91, scalar: 0.8})
    this.fire(0.1, {speed: 120, startVelocity: 25, decay: 0.92, scalar: 1.2})
    this.fire(0.1, {speed: 120, startVelocity: 45})
    
    // Remove canvas after 5 seconds
    setTimeout(function() {
      document.body.removeChild(canvas)
    }, 5000)
  }
  
  fire(particleRatio, options) {
    let count = 200
    let defaults = {origin: {y: 0.7}}
    
    this.confetti(Object.assign({}, defaults, options, {
      particleCount: Math.floor(count * particleRatio)
    }))
  }
  
  createCanvas() {
    document.body.insertAdjacentHTML('beforeend', `<canvas id="confetti" class="fixed inset-0 w-full h-full pointer-events-none z-50"></canvas>`)
  }
  
  get canvas() {
    return document.querySelector("#confetti")
  }
  
}