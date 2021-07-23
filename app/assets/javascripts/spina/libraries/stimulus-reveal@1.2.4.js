import { Controller } from 'stimulus'

/**
 * Stimulus controller to toggle element visibility
 * @extends Controller
 */
export default class RevealController extends Controller {
  static get values() {
    return {
      open: Boolean,
      transitioning: Boolean,
      targetSelector: String,
      toggleKeys: String,
      showKeys: String,
      hideKeys: String,
      away: Boolean,
      debug: Boolean,
    }
  }

  connect() {
    this._initCloseKeypressListener()
    this._initToggleKeypressListener()
    this._initShowKeypressListener()
  }

  /**
   * Shows elements connected to the controller.
   * @param {Event} event - an event with a currentTarget DOMElement
   */
  show(event) {
    if (this.openValue || this.transitioningValue) return

    this._init(event, true)
  }

  /**
   * Hides elements connected to the controller.
   * @param {Event} event - an event with a currentTarget DOMElement
   */
  hide(event) {
    if (!this.openValue || this.transitioningValue) return

    this._init(event, false)
  }

  /**
   * Toggles elements connected to the controller.
   * @param {Event} event - an event with a currentTarget DOMElement
   */
  toggle(event) {
    if (this.transitioningValue) return

    this._init(event, !this.openValue)
  }

  // Private methods

  /**
   * @private
   * @param {Event} event
   * @param {Event} shouldOpen
   */
  async _init(event, shouldOpen) {
    if (event && event.currentTarget && event.currentTarget.dataset) {
      if ('revealPreventDefault' in event.currentTarget.dataset) { event.preventDefault() }
      if ('revealStopPropagation' in event.currentTarget.dataset) { event.stopPropagation() }
    }
    // start stuff
    const startSelector = `${this.selector}[data-${shouldOpen ? 'enter' : 'leave'
      }-start]`
    const startPromises = this._didInitWithPromise(startSelector, shouldOpen)
    await Promise.all(startPromises)

    const defaultSelector = `${this.selector}:not([data-${shouldOpen ? 'enter' : 'leave'
      }-start]):not([data-${shouldOpen ? 'enter' : 'leave'}-end])`
    const defaultPromises = this._didInitWithPromise(
      defaultSelector,
      shouldOpen
    )
    await Promise.all(defaultPromises)

    // end stuff
    const endSelector = `${this.selector}[data-${shouldOpen ? 'enter' : 'leave'
      }-end]`
    const endPromises = this._didInitWithPromise(endSelector, shouldOpen)
    await Promise.all(endPromises)
  }

  _didInitWithPromise(selector, shouldOpen) {
    this._debug('selecting', selector, this.element.querySelectorAll(selector))
    return Array.from(this.element.querySelectorAll(selector)).map(
      (element) => {
        return this._doInitTransition(element, shouldOpen)
      }
    )
  }

  /**
   * @private
   */
  _initCloseKeypressListener() {
    if (this.hasHideKeysValue) {
      document.addEventListener('keydown', (event) => {
        if (!this.openValue) return
        if (!this.hideKeysValue.split(',').includes(event.key.toLowerCase())) {
          return
        }

        event.stopPropagation()
        this.toggle(event)
      })
    }
  }

  /**
   * @private
   */
  _initToggleKeypressListener() {
    if (this.hasToggleKeysValue) {
      document.addEventListener('keydown', (event) => {
        if (
          !this.toggleKeysValue.split(',').includes(event.key.toLowerCase())
        ) {
          return
        }

        event.stopPropagation()

        this.toggle(event)
      })
    }
  }

  /**
   * @private
   */
  _initShowKeypressListener() {
    if (this.hasShowKeysValue) {
      document.addEventListener('keydown', (event) => {
        if (this.openValue) return
        if (!this.showKeysValue.split(',').includes(event.key.toLowerCase())) {
          return
        }

        event.stopPropagation()

        this.toggle(event)
      })
    }
  }

  /**
   * @private
   */
  _awayHandler(event) {
    if (!this.element.contains(event.target)) {
      this.hide(event)
    }
    return true
  }

  /**
   * @private
   * @param {DOMElement} target
   * @param {boolean} openState
   */
  _doInitTransition(target, openState) {
    this._debug('init transition', `${openState ? 'open' : 'closed'}`, target)
    this._debug('dispatching event', `reveal:${openState ? 'show' : 'hide'}`, target)
    target.dispatchEvent(
      new Event(`reveal:${openState ? 'show' : 'hide'}`, {
        bubbles: true,
        cancelable: false,
      })
    )

    return new Promise((resolve, reject) => {
      if (
        'transition' in target.dataset &&
        this.element.offsetParent !== null
      ) {
        requestAnimationFrame(() => {
          this._transitionSetup(target, openState)
          const _didEndTransition = this._didEndTransition.bind(this)

          target.addEventListener(
            'transitionend',
            function _didEndTransitionHandler() {
              _didEndTransition(target, openState)
              target.removeEventListener(
                'transitionend',
                _didEndTransitionHandler
              )
              resolve()
            }
          )

          requestAnimationFrame(() => {
            this._doStartTransition(target, openState)
          })
        })
      } else {
        if (openState) {
          this._debug(
            'force hidden - init',
            `${openState ? 'open' : 'closed'}`,
            target
          )
          target.hidden = !target.hidden
        }
        this._doCompleteTransition(target, openState)
        resolve()
      }
    })
  }

  /**
   * @private
   * @param {DOMElement} target
   */
  _doStartTransition(target, openState) {
    this._debug('start transition', `${openState ? 'open' : 'closed'}`, target)
    this.transitioningValue = true
    if (target.dataset.useTransitionClasses === 'true') {
      const transitionClasses = this._transitionClasses(
        target,
        this.transitionType
      )
      target.classList.add(...transitionClasses.end.split(' '))
      target.classList.remove(...transitionClasses.start.split(' '))
    } else {
      const transitions = this._transitionDefaults(openState)
      target.style.transformOrigin = transitions.origin
      target.style.transitionProperty = 'opacity transform'
      target.style.transitionDuration = `${transitions.duration / 1000}s`
      target.style.transitionTimingFunction = 'cubic-bezier(0.4, 0.0, 0.2, 1)'

      target.style.opacity = transitions.to.opacity
      target.style.transform = `scale(${transitions.to.scale / 100})`
    }
  }

  /**
   * @private
   * @param {DOMElement} target
   * @param {boolean} openState
   */
  _didEndTransition(target, openState) {
    this._debug('end transition', `${openState ? 'open' : 'closed'}`, target)
    if (target.dataset.useTransitionClasses === 'true') {
      const transitionClasses = this._transitionClasses(
        target,
        this.transitionType
      )
      target.classList.remove(...transitionClasses.before.split(' '))
    } else {
      target.style.opacity = target.dataset.opacityCache
      target.style.transform = target.dataset.transformCache
      target.style.transformOrigin = target.dataset.transformOriginCache
    }
    this._doCompleteTransition(target, openState)
  }

  /**
   * @private
   * @param {DOMElement} target
   * @param {boolean} openState
   */
  _doCompleteTransition(target, openState) {
    this._debug(
      'complete transition',
      `${openState ? 'open' : 'closed'}`,
      target
    )
    this.transitioningValue = false

    if (!openState) {
      this._debug(
        'force hidden - complete',
        `${openState ? 'open' : 'closed'}`,
        target
      )
      target.hidden = !target.hidden
    }
    this.openValue = openState

    this._debug('dispatching event', `reveal:${openState ? 'shown' : 'hidden'}`, target)
    target.dispatchEvent(
      new Event(`reveal:${openState ? 'shown' : 'hidden'}`, {
        bubbles: true,
        cancelable: false,
      })
    )

    if (this.hasAwayValue) {
      if (openState) {
        this.awayHandler = this._awayHandler.bind(this)
        document.addEventListener('click', this.awayHandler)
      } else {
        document.removeEventListener('click', this.awayHandler)
      }
    }

    this._debug('dispatching event', 'reveal:complete', target)
    target.dispatchEvent(
      new Event('reveal:complete', { bubbles: true, cancelable: false })
    )
  }

  /**
   * @private
   * @param {DOMElement} target
   * @param {boolean} openState
   */
  _transitionSetup(target, openState) {
    this.transitionType = openState ? 'transitionEnter' : 'transitionLeave'

    if (this.transitionType in target.dataset) {
      target.dataset.useTransitionClasses = true
      const transitionClasses = this._transitionClasses(
        target,
        this.transitionType
      )
      target.classList.add(...transitionClasses.before.split(' '))
      target.classList.add(...transitionClasses.start.split(' '))
    } else {
      target.dataset.useTransitionClasses = false
      const transitions = this._transitionDefaults(openState)
      target.dataset.opacityCache = target.style.opacity
      target.dataset.transformCache = target.style.transform
      target.dataset.transformOriginCache = target.style.transformOrigin

      target.style.opacity = transitions.from.opacity
      target.style.transform = `scale(${transitions.from.scale / 100})`
    }
    if (openState) {
      this._debug('opening with transition', target)
      target.hidden = !target.hidden
    }
  }

  /**
   * @private
   * @param {boolean} openState
   */
  _transitionDefaults(openState) {
    return {
      duration: openState ? 200 : 150,
      origin: 'center',
      from: {
        opacity: openState ? 0 : 1,
        scale: openState ? 95 : 100,
      },
      to: {
        opacity: openState ? 1 : 0,
        scale: openState ? 100 : 95,
      },
    }
  }

  /**
   * @private
   * @param {DOMElement} target
   * @param {string} transitionType
   */
  _transitionClasses(target, transitionType) {
    return {
      before: target.dataset[transitionType],
      start: target.dataset[`${transitionType}Start`],
      end: target.dataset[`${transitionType}End`],
    }
  }

  _debug(...args) {
    if (this.debugValue) console.log(...args)
  }

  get selector() {
    return this.hasTargetSelectorValue
      ? this.targetSelectorValue
      : '[data-reveal]'
  }
}

export {
  RevealController
}
