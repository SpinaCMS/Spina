module Spina
  class ViewsGenerator < Rails::Generators::Base

    source_root Spina::Engine.root

    def copy_views
      template 'app/views/layouts/spina/admin/website.html.haml'
      template 'app/views/layouts/spina/admin/messages.html.haml'
      template 'app/views/layouts/spina/admin/settings.html.haml'
      template 'app/views/spina/admin/shared/_primary_navigation.html.haml'
    end

  end
end
