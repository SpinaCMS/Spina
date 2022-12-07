# Allows SVGs to be displayed as they are not variable. Requires:
# - https://github.com/Dreamersoul/administrate-field-active_storage/issues/36#issuecomment-608446819 to be applied
#
# Additionally, https://github.com/hopsoft/active_storage_svg_sanitizer/
# should be added if users are able to upload their own SVG content due to:
# https://github.com/rails/rails/issues/34665#issuecomment-445888009
Rails.application.config.active_storage.content_types_to_serve_as_binary.delete("image/svg+xml")
