require 'spina/engine'
require 'spina/template'

module Spina

  include ActiveSupport::Configurable

  config_accessor :backend_path, :storage

  self.backend_path = 'admin'

  self.storage = :file

  self.max_page_depth = 5

end
