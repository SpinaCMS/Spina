module Spina::SpinaHelper

  def spina_importmap_tags
    safe_join [
      javascript_inline_importmap_tag(Spina.config.importmap),
      javascript_importmap_shim_tag,
      javascript_include_tag("spina/libraries/trix"),
      javascript_import_module_tag("application")
    ], "\n"
  end
  

end