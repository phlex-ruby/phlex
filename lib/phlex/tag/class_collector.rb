module Phlex
  class Tag
    class ClassCollector
      def initialize(context, tag)
        @context = context
        @tag = tag
      end

      def method_missing(name, content = nil, *args, **attributes, &block)
        @tag.attributes = { class: name }
        @tag.attributes = attributes

        return @context.render_tag(@tag, &block) if block_given?
        return @context.render_tag(@tag) { text content } if content
        self
      end
    end
  end
end
