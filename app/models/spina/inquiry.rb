module Spina
  class Inquiry < ActiveRecord::Base
    include ActionView::Helpers::TextHelper

    validates_presence_of :email, :message, :name
    validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

    before_save :archive_if_spam

    # Filters spam gem incompatible met rails 4.1
    # filters_spam({
    #   author_field: :name,
    #   message_field: :message,
    #   email_field: :email,
    #   other_fields: [],
    #   extra_spam_words: %w()
    # })

    scope :ham, -> { where(spam: [false, nil]) }
    scope :spam, -> { where(spam: true)}
    scope :new_messages, -> { ham.where(archived: false) }
    scope :sorted, -> { ham.order("created_at DESC") }

    def archive_if_spam
      self.archived = true if self.spam
    end

    def summary
      truncate(message, length: 120)
    end

    def ham!
      update_attributes({spam: false}, without_protection: true)
    end

    def spam!
      update_attributes({spam: true}, without_protection: true)
    end

  end
end
