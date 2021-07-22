class Spina::SitemapsController < Spina::ApplicationController
  
  def show
    I18n.locale = I18n.default_locale
    @pages = Spina::Page.live.sorted
  end
  
end
