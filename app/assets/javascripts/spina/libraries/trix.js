import "libraries/trix@1.3.1.esm"

// Extra headings
Trix.config.blockAttributes.heading2 = {
  tagName: "h2", terminal: true, breakOnReturn: true, group: false }
Trix.config.blockAttributes.heading3 = {
  tagName: "h3", terminal: true, breakOnReturn: true, group: false }
Trix.config.blockAttributes.heading4 = {
  tagName: "h4", terminal: true, breakOnReturn: true, group: false }
