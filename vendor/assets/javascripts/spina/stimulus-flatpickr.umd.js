//= require_tree ./flatpickr

(function (global, factory) {
  typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory(require('stimulus'), require('flatpickr')) :
  typeof define === 'function' && define.amd ? define(['stimulus', 'flatpickr'], factory) :
  (global = global || self, global['stimulus-flatpickr'] = factory(global.Stimulus, global.flatpickr));
}(this, (function (stimulus, flatpickr) { 'use strict';

  flatpickr = flatpickr && Object.prototype.hasOwnProperty.call(flatpickr, 'default') ? flatpickr['default'] : flatpickr;

  function _classCallCheck(instance, Constructor) {
    if (!(instance instanceof Constructor)) {
      throw new TypeError("Cannot call a class as a function");
    }
  }

  function _defineProperties(target, props) {
    for (var i = 0; i < props.length; i++) {
      var descriptor = props[i];
      descriptor.enumerable = descriptor.enumerable || false;
      descriptor.configurable = true;
      if ("value" in descriptor) descriptor.writable = true;
      Object.defineProperty(target, descriptor.key, descriptor);
    }
  }

  function _createClass(Constructor, protoProps, staticProps) {
    if (protoProps) _defineProperties(Constructor.prototype, protoProps);
    if (staticProps) _defineProperties(Constructor, staticProps);
    return Constructor;
  }

  function _defineProperty(obj, key, value) {
    if (key in obj) {
      Object.defineProperty(obj, key, {
        value: value,
        enumerable: true,
        configurable: true,
        writable: true
      });
    } else {
      obj[key] = value;
    }

    return obj;
  }

  function ownKeys(object, enumerableOnly) {
    var keys = Object.keys(object);

    if (Object.getOwnPropertySymbols) {
      var symbols = Object.getOwnPropertySymbols(object);
      if (enumerableOnly) symbols = symbols.filter(function (sym) {
        return Object.getOwnPropertyDescriptor(object, sym).enumerable;
      });
      keys.push.apply(keys, symbols);
    }

    return keys;
  }

  function _objectSpread2(target) {
    for (var i = 1; i < arguments.length; i++) {
      var source = arguments[i] != null ? arguments[i] : {};

      if (i % 2) {
        ownKeys(Object(source), true).forEach(function (key) {
          _defineProperty(target, key, source[key]);
        });
      } else if (Object.getOwnPropertyDescriptors) {
        Object.defineProperties(target, Object.getOwnPropertyDescriptors(source));
      } else {
        ownKeys(Object(source)).forEach(function (key) {
          Object.defineProperty(target, key, Object.getOwnPropertyDescriptor(source, key));
        });
      }
    }

    return target;
  }

  function _inherits(subClass, superClass) {
    if (typeof superClass !== "function" && superClass !== null) {
      throw new TypeError("Super expression must either be null or a function");
    }

    subClass.prototype = Object.create(superClass && superClass.prototype, {
      constructor: {
        value: subClass,
        writable: true,
        configurable: true
      }
    });
    if (superClass) _setPrototypeOf(subClass, superClass);
  }

  function _getPrototypeOf(o) {
    _getPrototypeOf = Object.setPrototypeOf ? Object.getPrototypeOf : function _getPrototypeOf(o) {
      return o.__proto__ || Object.getPrototypeOf(o);
    };
    return _getPrototypeOf(o);
  }

  function _setPrototypeOf(o, p) {
    _setPrototypeOf = Object.setPrototypeOf || function _setPrototypeOf(o, p) {
      o.__proto__ = p;
      return o;
    };

    return _setPrototypeOf(o, p);
  }

  function _isNativeReflectConstruct() {
    if (typeof Reflect === "undefined" || !Reflect.construct) return false;
    if (Reflect.construct.sham) return false;
    if (typeof Proxy === "function") return true;

    try {
      Date.prototype.toString.call(Reflect.construct(Date, [], function () {}));
      return true;
    } catch (e) {
      return false;
    }
  }

  function _assertThisInitialized(self) {
    if (self === void 0) {
      throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
    }

    return self;
  }

  function _possibleConstructorReturn(self, call) {
    if (call && (typeof call === "object" || typeof call === "function")) {
      return call;
    }

    return _assertThisInitialized(self);
  }

  function _createSuper(Derived) {
    return function () {
      var Super = _getPrototypeOf(Derived),
          result;

      if (_isNativeReflectConstruct()) {
        var NewTarget = _getPrototypeOf(this).constructor;

        result = Reflect.construct(Super, arguments, NewTarget);
      } else {
        result = Super.apply(this, arguments);
      }

      return _possibleConstructorReturn(this, result);
    };
  }

  const kebabCase = string => string.replace(/([a-z])([A-Z])/g, "$1-$2").replace(/[\s_]+/g, "-").toLowerCase();
  const capitalize = string => {
    return string.charAt(0).toUpperCase() + string.slice(1);
  };

  const booleanOptions = ['allowInput', 'altInput', 'animate', 'clickOpens', 'closeOnSelect', 'disableMobile', 'enableSeconds', 'enableTime', 'inline', 'noCalendar', 'shorthandCurrentMonth', 'static', 'time_24hr', 'weekNumbers', 'wrap'];
  const stringOptions = ['altInputClass', 'conjunction', 'mode', 'nextArrow', 'position', 'prevArrow', 'monthSelectorType'];
  const numberOptions = ['defaultHour', 'defaultMinute', 'defaultSeconds', 'hourIncrement', 'minuteIncrement', 'showMonths'];
  const arrayOptions = ['disable', 'enable', 'disableDaysOfWeek', 'enableDaysOfWeek'];
  const arrayOrStringOptions = ['defaultDate'];
  const dateOptions = ['maxDate', 'minDate', 'maxTime', 'minTime', 'now'];
  const dateFormats = ['altFormat', 'ariaDateFormat', 'dateFormat'];
  const options = {
    string: stringOptions,
    boolean: booleanOptions,
    date: dateOptions,
    array: arrayOptions,
    number: numberOptions,
    arrayOrString: arrayOrStringOptions
  };

  const events = ['change', 'open', 'close', 'monthChange', 'yearChange', 'ready', 'valueUpdate', 'dayCreate'];

  const elements = ['calendarContainer', 'currentYearElement', 'days', 'daysContainer', 'input', 'nextMonthNav', 'monthNav', 'prevMonthNav', 'rContainer', 'selectedDateElem', 'todayDateElem', 'weekdayContainer'];

  const mapping = {
    '%Y': 'Y',
    '%y': 'y',
    '%C': 'Y',
    '%m': 'm',
    '%-m': 'n',
    '%_m': 'n',
    '%B': 'F',
    '%^B': 'F',
    '%b': 'M',
    '%^b': 'M',
    '%h': 'M',
    '%^h': 'M',
    '%d': 'd',
    '%-d': 'j',
    '%e': 'j',
    '%H': 'H',
    '%k': 'H',
    '%I': 'h',
    '%l': 'h',
    '%-l': 'h',
    '%P': 'K',
    '%p': 'K',
    '%M': 'i',
    '%S': 'S',
    '%A': 'l',
    '%a': 'D',
    '%w': 'w'
  };
  const strftimeRegex = new RegExp(Object.keys(mapping).join('|').replace(new RegExp('\\^', 'g'), '\\^'), 'g');
  const convertDateFormat = format => {
    return format.replace(strftimeRegex, match => {
      return mapping[match];
    });
  };

  let StimulusFlatpickr = /*#__PURE__*/function (_Controller) {
    _inherits(StimulusFlatpickr, _Controller);

    var _super = _createSuper(StimulusFlatpickr);

    function StimulusFlatpickr() {
      _classCallCheck(this, StimulusFlatpickr);

      return _super.apply(this, arguments);
    }

    _createClass(StimulusFlatpickr, [{
      key: "initialize",
      value: function initialize() {
        this.config = {};
      }
    }, {
      key: "connect",
      value: function connect() {
        this._initializeEvents();

        this._initializeOptions();

        this._initializeDateFormats();

        this.fp = flatpickr(this.flatpickrElement, _objectSpread2({}, this.config));

        this._initializeElements();
      }
    }, {
      key: "disconnect",
      value: function disconnect() {
        const value = this.inputTarget.value;
        this.fp.destroy();
        this.inputTarget.value = value;
      }
    }, {
      key: "_initializeEvents",
      value: function _initializeEvents() {
        events.forEach(event => {
          if (this[event]) {
            const hook = `on${capitalize(event)}`;
            this.config[hook] = this[event].bind(this);
          }
        });
      }
    }, {
      key: "_initializeOptions",
      value: function _initializeOptions() {
        Object.keys(options).forEach(optionType => {
          const optionsCamelCase = options[optionType];
          optionsCamelCase.forEach(option => {
            const optionKebab = kebabCase(option);

            if (this.data.has(optionKebab)) {
              this.config[option] = this[`_${optionType}`](optionKebab);
            }
          });
        });

        this._handleDaysOfWeek();
      }
    }, {
      key: "_handleDaysOfWeek",
      value: function _handleDaysOfWeek() {
        if (this.config.disableDaysOfWeek) {
          this.config.disableDaysOfWeek = this._validateDaysOfWeek(this.config.disableDaysOfWeek);
          this.config.disable = [...(this.config.disable || []), this._disable.bind(this)];
        }

        if (this.config.enableDaysOfWeek) {
          this.config.enableDaysOfWeek = this._validateDaysOfWeek(this.config.enableDaysOfWeek);
          this.config.enable = [...(this.config.enable || []), this._enable.bind(this)];
        }
      }
    }, {
      key: "_validateDaysOfWeek",
      value: function _validateDaysOfWeek(days) {
        if (Array.isArray(days)) {
          return days.map(day => parseInt(day));
        } else {
          console.error('days of week must be a valid array');
          return [];
        }
      }
    }, {
      key: "_disable",
      value: function _disable(date) {
        const disabledDays = this.config.disableDaysOfWeek;
        return disabledDays.includes(date.getDay());
      }
    }, {
      key: "_enable",
      value: function _enable(date) {
        const enabledDays = this.config.enableDaysOfWeek;
        return enabledDays.includes(date.getDay());
      }
    }, {
      key: "_initializeDateFormats",
      value: function _initializeDateFormats() {
        dateFormats.forEach(dateFormat => {
          if (this.data.has(dateFormat)) {
            this.config[dateFormat] = convertDateFormat(this.data.get(dateFormat));
          }
        });
      }
    }, {
      key: "_initializeElements",
      value: function _initializeElements() {
        elements.forEach(element => {
          this[`${element}Target`] = this.fp[element];
        });
      }
    }, {
      key: "_string",
      value: function _string(option) {
        return this.data.get(option);
      }
    }, {
      key: "_date",
      value: function _date(option) {
        return this.data.get(option);
      }
    }, {
      key: "_boolean",
      value: function _boolean(option) {
        return !(this.data.get(option) == '0' || this.data.get(option) == 'false');
      }
    }, {
      key: "_array",
      value: function _array(option) {
        return JSON.parse(this.data.get(option));
      }
    }, {
      key: "_number",
      value: function _number(option) {
        return parseInt(this.data.get(option));
      }
    }, {
      key: "_arrayOrString",
      value: function _arrayOrString(option) {
        const val = this.data.get(option);

        try {
          return JSON.parse(val);
        } catch (e) {
          return val;
        }
      }
    }, {
      key: "flatpickrElement",
      get: function () {
        return this.hasInstanceTarget && this.instanceTarget || this.element;
      }
    }]);

    return StimulusFlatpickr;
  }(stimulus.Controller);

  _defineProperty(StimulusFlatpickr, "targets", ['instance']);

  window.StimulusFlatpickr = StimulusFlatpickr;

})));
