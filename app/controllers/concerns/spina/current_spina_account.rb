module Spina
  module CurrentSpinaAccount
    extend ActiveSupport::Concern

    included do
      before_action :current_spina_account
      helper_method :current_spina_account
      helper_method :current_account
    end

    private

    def current_account
      ActiveSupport::Deprecation.warn(
        "#current_account is deprecated, due to a common authentication namespace conflict. \n" \
        "Please use #current_spina_account instead."
      )
      current_spina_account
    end

    def current_spina_account
      Spina::Current.account ||= ::Spina::Account.first
    end

    remove_method :current_account if Spina.config.disable_current_account
  end
end
