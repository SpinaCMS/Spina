module Spina
  class SitemapsController < Spina::ApplicationController
    def show
      @pages = Page.live.sorted
    end
  end
end
