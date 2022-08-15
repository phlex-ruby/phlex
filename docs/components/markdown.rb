module Components
  class Markdown < Phlex::Component
    class Render < Redcarpet::Render::HTML
      def header(text, level)
        case level
        when 1
          Title.new { text }.call
        else
          Heading.new { text }.call
        end
      end
    end

    MARKDOWN = Redcarpet::Markdown.new(Render.new, autolink: true, tables: true)

    def initialize(content)
      @content = content
    end

    def template
      _raw MARKDOWN.render(@content)
    end
  end
end
