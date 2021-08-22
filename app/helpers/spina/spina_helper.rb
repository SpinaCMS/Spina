module Spina::SpinaHelper

  def spina_importmap_tags(entry_point = "application")
    safe_join [
      javascript_inline_importmap_tag(Spina.config.importmap.to_json(resolver: self)),
      javascript_importmap_module_preload_tags(Spina.config.importmap),
      javascript_importmap_shim_tag,
      javascript_import_module_tag(entry_point)
    ], "\n"
  end

end