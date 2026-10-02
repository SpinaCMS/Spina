# frozen_string_literal: true

# Global layout parts are editable in the admin under Layout.
# Uncomment one of the examples below, or add your own parts.
#
# Flat list:
#
# Spina.define_layout_parts do
#   part :footer, :text, title: "Footer"
# end
#
# Or split into tabs with sections (labels via spina.layout.sections.<name>):
#
# Spina.define_layout_parts do
#   section :general do
#     part :footer, :text, title: "Footer"
#   end
#
#   section :seo do
#     part :meta_title, :line
#   end
# end
