import { Controller } from '@hotwired/stimulus'

/**
 * One way data and visibility bindings for inputs
 * @extends Controller
 */
export default class DataBindingController extends Controller {
  /**
   * Initialize bindings on connection to the DOM
   */
  connect() {
    if (this.element.dataset.bindingDebug === "true") {
      this.debugMode = true
    }

    this._debug("stimulus-data-binding: connecting to wrapper:", this.element)

    const sourceElements = Array.from(this.element.querySelectorAll('[data-binding-target]'))
    if (this.element.dataset.bindingTarget) sourceElements.unshift(this.element)

    if (sourceElements.length === 0) this._debug("No source elements found. Did you set data-binding-target on your source elements?")

    for (const sourceElement of sourceElements) {
      if (this.debugMode) console.group("stimulus-data-binding: Source element")
      this._debug("Source element found", sourceElement)

      if (sourceElement.dataset.bindingInitial !== 'false') {
        this._debug("Running initial binding on source element")
        this._runBindings(sourceElement)
      } else {
        this._debug("%cNot running initial binding on source element as binding-initial is set to false", "color: rgba(150,150,150,0.8);")
      }

      if (this.debugMode) console.groupEnd()
    }
  }

  /**
   * Updates bindings for the current element.
   * @param {Event} e - an event with a currentTarget DOMElement
   */
  update(e) {
    this._runBindings(e.currentTarget)
  }

  /**
   * @private
   * @param {DOMElement} source
   */
  _runBindings(source) {
    this._debug("Searching for targets for source: ", source)
    for (const targetRef of source.dataset.bindingTarget.split(' ')) {
      const targetElements = this._bindingElements(targetRef)

      if (targetElements.length === 0) this._debug(`Could not find any target elements for ref ${targetRef}. Have you set data-target-ref="${targetRef}" on your target elements?`)

      for (const target of targetElements) {
        if (this.debugMode) console.group("stimulus-data-binding: Target Element")
        this._debug("Target found. Running bindings for target: ", target)

        const bindingCondition = this._getDatum('bindingCondition', source, target)

        if (bindingCondition) {
          this._debug(`Evaluating binding condition: '${bindingCondition}'`)
        } else {
          this._debug(`%cNo binding condition set. Evaluating as true. To add a condition set 'data-binding-condition="..."'`, "color: rgba(150,150,150,0.8);")
        }

        const conditionPassed = this._evaluate(
          bindingCondition,
          {
            source,
            target
          }
        )

        if (conditionPassed) {
          this._debug(`Condition evaluated to: `, conditionPassed)
        } else {
          this._debug(`Condition evaluated to: `, conditionPassed)
        }

        const bindingValue = this._getDatum('bindingValue', source, target)

        if (bindingValue) {
          this._debug(`Evaluating binding value: '${bindingValue}'`)
        } else {
          this._debug(`%cNo binding value set, evaluating as true. to set a value for the attribute / property on your target elements set 'data-binding-value="..."'`, "color: rgba(150,150,150,0.8);")
        }

        const value = this._evaluate(
          bindingValue,
          {
            source,
            target
          }
        )

        this._debug(`Value evaluated to: '${value}'`)

        const bindingAttribute = this._getDatum(
          'bindingAttribute',
          source,
          target
        )

        if (!bindingAttribute) {
          this._debug(`%cNo binding attribute set. To add attributes to your target element set 'data-binding-attribute="..."'`, "color: rgba(150,150,150,0.8);")
        }

        if (bindingAttribute) {
          for (const attribute of bindingAttribute.split(' ')) {
            if (conditionPassed) {
              this._debug(`Condition passed so setting attribute '${attribute}' to '${value}'`)
              target.setAttribute(attribute, value)
            } else {
              this._debug(`Condition failed so removing attribute '${attribute}'`)
              target.removeAttribute(attribute)
            }
          }
        }

        const bindingProperty = this._getDatum(
          'bindingProperty',
          source,
          target
        )

        if (!bindingProperty) {
          this._debug(`%cNo binding property set. To add properties to your target element set 'data-binding-property="..."'`, "color: rgba(150,150,150,0.8);")
        }

        if (bindingProperty) {
          for (const prop of bindingProperty.split(' ')) {
            const propertyValue = conditionPassed ? value : ''
            if (target[prop] != propertyValue) { target.dataset.hasChanged = true }

            if (conditionPassed) {
              this._debug(`Condition passed so setting property '${prop}' from ${target[prop]} to '${value}'`)
            } else {
              this._debug(`Condition failed so setting property '${prop}' from ${target[prop]} to '' (empty string)`)
            }

            target[prop] = propertyValue
          }
        }

        const bindingClass = this._getDatum(
          'bindingClass',
          source,
          target
        )

        if (!bindingClass) {
          this._debug(`%cNo binding class set. To add classes to your target element set 'data-binding-class="..."'`, "color: rgba(150,150,150,0.8);")
        }

        if (bindingClass) {
          for (const klass of bindingClass.split(' ')) {
            if (conditionPassed) {
              this._debug(`Condition passed so adding class '${klass}'`)
              target.classList.add(klass)
            } else {
              this._debug(`Condition failed so removing class '${klass}'`)
              target.classList.remove(klass)
            }
          }
        }

        const bindingEvent = this._getDatum('bindingEvent', source, target)

        if (!bindingEvent) {
          this._debug(`%cNo binding event set. To dispatch events on property change to your target element set 'data-binding-event="..."'`, "color: rgba(150,150,150,0.8);")
        }

        if (bindingEvent) {
          for (const event of bindingEvent.split(' ')) {
            if (target.dataset.hasChanged) {
              this._debug(`Target has changed so dispatching event ${event}`)
              target.dispatchEvent(new Event(event, { cancelable: true, bubbles: true }))
              delete target.dataset.hasChanged
            } else {
              this._debug(`No changes to target properties so not dispatching '${event}'`)
            }
          }
        }

        if (this.debugMode) console.groupEnd()
      }
    }
  }

  /**
   * @private
   * @param {String} name - the name of the binding reference
   */
  _bindingElements(name) {
    return this.element.querySelectorAll(`[data-binding-ref="${name}"]`)
  }

  /**
   * @private
   * @param {String} attribute - the attribute to fetch from the source / target dataaset
   * @param {String} source - The source element to get the attribute from, only loads if target doesnt have it
   * @param {String} target - The target element to get the attribute from, has precedence over the source
   */
  _getDatum(attribute, source, target) {
    return target.dataset[attribute] || source.dataset[attribute]
  }

  /**
   * @private
   * @param {String} expression - expression to safe eval
   * @param {Object} variables - variables to be present when evaluating the given expression
   */
  _evaluate(expression, variables = {}) {
    if (!expression) return true
    return new Function(
      Object.keys(variables).map((v) => `$${v}`),
      `return ${expression.trim()}`
    )(...Object.values(variables))
  }

  /**
  * @private
  * @param {String} expression - expression to safe eval
  * @param {Object} variables - variables to be present when evaluating the given expression
  */
  _debug(...args) {
    if (this.debugMode) {
      console.log(...args)
    }
  }
}
