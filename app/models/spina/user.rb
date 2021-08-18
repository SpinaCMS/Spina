module Spina
  class User < ApplicationRecord
    include Gravatar
    
    has_secure_password
    has_secure_token :password_reset_token

    validates :name, presence: true
    validates :email, uniqueness: true, presence: true, format: { with:/\A[^@]+@[^@]+\z/ }

    def admin?
      admin
    end

    def to_s
      name
    end
    
    def regenerate_password_token!
      regenerate_password_reset_token
      self.password_reset_sent_at = Time.current
      save!
    end

  end
end
