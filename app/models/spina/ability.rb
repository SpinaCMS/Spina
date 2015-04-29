module Spina
  class Ability
    include CanCan::Ability

    def initialize(user)
      if user.admin?
        can :manage, :all
      else
        can :manage, Page
        can :manage, Photo
        can :manage, Attachment
        can :manage, Account
        can :manage, Inquiry

        # Engine.config.plugins.each do |plugin|
        #   can :manage, "#{plugin.class_name}".constantize
        # end
      end
    end
  end
end