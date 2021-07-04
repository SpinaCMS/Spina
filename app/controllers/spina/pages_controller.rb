class Spina::PagesController < Spina::ApplicationController
  include Spina::Frontend

  before_action -> { authorize(page) }

  helper_method :page

  def homepage
    render_with_template(page)
  end

end
