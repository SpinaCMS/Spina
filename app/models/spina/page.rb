module Spina
  class Page < ActiveRecord::Base
    extend FriendlyId
    include Spina::Partable

    has_ancestry orphan_strategy: :adopt # i.e. added to the parent of deleted node

    friendly_id :slug_candidates, use: [:slugged, :finders]

    has_many :page_parts, dependent: :destroy

    before_validation :ensure_title
    before_save :set_materialized_path
    before_save :ancestry_is_nil
    after_save :save_children

    accepts_nested_attributes_for :page_parts, allow_destroy: true
    validates_presence_of :title

    scope :sorted, -> { order('position') }
    scope :custom_pages, -> { where(deletable: false) }
    scope :live, -> { where(draft: false, active: true) }
    scope :in_menu, -> { where(show_in_menu: true) }
    scope :active, -> { where(active: true) }

    alias_method :page_part, :part
    alias_method :parts, :page_parts

    def slug_candidates
      [
        :title, 
        [:title, :id]
      ]
    end

    def should_generate_new_friendly_id?
      title_changed?
    end

    def to_s
      name
    end

    def custom_page?
      !deletable
    end

    def set_materialized_path
      self.materialized_path = generate_materialized_path
    end

    def save_children
      self.children.each { |child| child.save }
    end

    def menu_title
      read_attribute(:menu_title).blank? ? title : read_attribute(:menu_title)
    end

    def seo_title
      read_attribute(:seo_title).blank? ? title : read_attribute(:seo_title)
    end

    # def page_part(page_part)
    #   part(page_part)
    # end

    def has_content?(page_part)
      content(page_part).present?
    end

    def content(page_part)
      page_part = page_parts.where(name: page_part).first
      page_part.try(:content)
    end

    def live?
      !draft? && active?
    end

    def previous_sibling
      self.siblings.where('position < ?', self.position).sorted.last
    end

    def next_sibling
      self.siblings.where('position > ?', self.position).sorted.first
    end

    def deactivate!
      self.active = false
      self.save
    end

    def activate!
      self.active = true
      self.save
    end

    private

    def generate_materialized_path
      if self.name == 'homepage'
        "/"
      else
        case self.depth
        when 0
          "/#{slug}"
        when 1
          "/#{self.parent.slug}/#{slug}"
        when 2
          "/#{self.parent.parent.try(:slug)}/#{self.parent.slug}/#{slug}"
        end
      end
    end

    def ancestry_is_nil
      if self.ancestry && self.ancestry.empty?
        self.ancestry = nil
      end
    end

    def ensure_title
      self.title = self.name.capitalize if self.title.blank? && self.name.present?
    end

  end
end
