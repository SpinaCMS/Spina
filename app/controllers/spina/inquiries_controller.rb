module Spina
  class InquiriesController < Spina::ApplicationController

    before_filter :setup_negative_captcha, only: [:create]

    def create
      @inquiry = Inquiry.new(@captcha.values)

      if @inquiry.save
        @inquiry.spam! unless @captcha.valid?
        InquiryMailer.inquiry(@inquiry).deliver unless @inquiry.spam
      else
        flash[:notice] = @captcha.error if @captcha.error
        render :failed
      end
    end

    private

    def setup_negative_captcha
      @captcha = NegativeCaptcha.new(
        secret: Engine.config.NEGATIVE_CAPTCHA_SECRET,
        spinner: request.remote_ip,
        fields: [:email, :message, :name],
        params: params
      )
    end

  end
end
