module Spina
  class User < ApplicationRecord
    has_secure_password
    has_secure_token :password_reset_token

    validates_presence_of :name, :email
    validates_presence_of :password, on: :create
    validate :uniqueness_of_email
    validates :email, format: { with:/\A[^@]+@[^@]+\z/ }

    def admin?
      admin
    end

    def to_s
      name
    end

    def update_last_logged_in!
      self.last_logged_in = Time.now
      self.save!
    end

    private

    def uniqueness_of_email
      if email_changed? && User.where(email: email).exists?
        errors.add(:email, I18n.t('errors.messages.taken'))
      end
    end
  end
end
