module Spina
  class SitemapsController < ApplicationController
    def show
      @pages = Page.sorted
    end
  end
end