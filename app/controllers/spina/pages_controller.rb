class Spina::PagesController < Spina::ApplicationController
  include Spina::Frontend

  before_action :authorize_page

  helper_method :page

  def homepage
    render_with_template(page)
  end

  private

  def authorize_page
    raise ActiveRecord::RecordNotFound unless page.live? || logged_in?
  end
end
