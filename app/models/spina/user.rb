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

  end
end
