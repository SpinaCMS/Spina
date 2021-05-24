module Spina::SpinaHelper

  def spina_include_tags
    safe_join [
      javascript_include_tag("stimulus/libraries/es-module-shims", type: "module"),
      tag.script(type: "importmap-shim", src: asset_path("spina/importmap.json")),
      javascript_include_tag("stimulus/libraries/stimulus", type: "module-shim"),
      javascript_include_tag("spina/libraries/trix")
    ], "\n"
  end
  
  def autoloader_include_tag
    javascript_include_tag("stimulus/loaders/autoloader", type: "module-shim")
  end

end