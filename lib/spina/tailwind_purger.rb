# frozen_string_literal: true

class Spina::TailwindPurger
  CLASS_NAME_PATTERN = /[:A-Za-z0-9_-]+[\.]*[\\\/:A-Za-z0-9_-]*/

  CLASS_BREAK = /(?![-_a-z0-9\\])/i # `\b` for class selectors

  COMMENT = /#{Regexp.escape "/*"}.*?#{Regexp.escape "*/"}/m
  COMMENTS_AND_BLANK_LINES = /\A(?:^#{COMMENT}?[ \t]*(?:\n|\z)|[ \t]*#{COMMENT})+/

  AT_RULE = /@[^{]+/
  CLASSLESS_SELECTOR_GROUP = /[^.{]+/
  CLASSLESS_BEGINNING_OF_BLOCK = /\A\s*(?:#{AT_RULE}|#{CLASSLESS_SELECTOR_GROUP})\{\n?/

  SELECTOR_GROUP = /[^{]+/
  BEGINNING_OF_BLOCK = /\A#{SELECTOR_GROUP}\{\n?/

  PROPERTY_NAME = /[-_a-z0-9]+/i
  PROPERTY_VALUE = /(?:[^;]|;\S)+/
  PROPERTIES = /\A(?:\s*#{PROPERTY_NAME}:#{PROPERTY_VALUE};\n?)+/

  END_OF_BLOCK = /\A\s*\}\n?/

  attr_reader :keep_these_class_names

  class << self
    def purge(input, keeping_class_names_from_files:)
      new(extract_class_names_from(keeping_class_names_from_files)).purge(input)
    end

    def extract_class_names(string)
      string.scan(CLASS_NAME_PATTERN).uniq.sort!
    end

    def extract_class_names_from(files)
      Array(files).flat_map { |file| extract_class_names(file.read) }.uniq.sort!
    end

    def escape_class_selector(class_name)
      class_name.gsub(/\A\d|[^-_a-z0-9]/, '\\\\\0')
    end
  end

  def initialize(keep_these_class_names)
    @keep_these_class_names = keep_these_class_names
  end

  def purge(input)
    conveyor = Conveyor.new(input)

    until conveyor.done?
      conveyor.discard(COMMENTS_AND_BLANK_LINES) \
      or conveyor.conditionally_keep(PROPERTIES) { conveyor.staged_output.last != "" } \
      or conveyor.conditionally_keep(END_OF_BLOCK) { not conveyor.staged_output.pop } \
      or conveyor.stage_output(CLASSLESS_BEGINNING_OF_BLOCK) \
      or conveyor.stage_output(BEGINNING_OF_BLOCK) { |match| purge_beginning_of_block(match.to_s) } \
      or raise "infinite loop"
    end

    conveyor.output
  end

  private
    def keep_these_selectors_pattern
      @keep_these_selectors_pattern ||= begin
        escaped_classes = @keep_these_class_names.map { |name| Regexp.escape self.class.escape_class_selector(name) }
        /(?:\A|,)[^.,{]*(?:[.](?:#{escaped_classes.join("|")})#{CLASS_BREAK}[^.,{]*)*(?=[,{])/
      end
    end

    def purge_beginning_of_block(string)
      purged = string.scan(keep_these_selectors_pattern).join
      unless purged.empty?
        purged.sub!(/\A,\s*/, "")
        purged.rstrip!
        purged << " {\n"
      end
      purged
    end

    class Conveyor
      attr_reader :output, :staged_output

      def initialize(input, output = +"")
        @input = input
        @output = output
        @staged_output = []
      end

      def consume(pattern)
        match = pattern.match(@input)
        @input = match.post_match if match
        match
      end
      alias :discard :consume

      def stage_output(pattern)
        if match = consume(pattern)
          string = block_given? ? (yield match) : match.to_s
          @staged_output << string
          string
        end
      end

      def keep(pattern)
        if match = consume(pattern)
          string = block_given? ? (yield match) : match.to_s
          @output << @staged_output.shift until @staged_output.empty?
          @output << string
          string
        end
      end

      def conditionally_keep(pattern)
        keep(pattern) do |match|
          (yield match) ? match.to_s : (break "")
        end
      end

      def done?
        @input.empty?
      end
    end
end