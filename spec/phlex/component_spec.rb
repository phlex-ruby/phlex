# frozen_string_literal: true

class CardComponent < Phlex::Component
  def template(&)
    article.p_5.rounded.drop_shadow(&)
  end
end

class Article
  include ActiveModel::Model

  attr_accessor :title

  def to_partial_path
    File.expand_path("../../examples/partials/article", __dir__)
  end
end

RSpec.describe Phlex::Component do
  let(:output) { example.call }
  let(:example) { component.new }

  describe "with text" do
    let :component do
      Class.new Phlex::Component do
        def template
          text "Hi"
        end
      end
    end

    it "produces the correct output" do
      expect(output).to eq "Hi"
    end
  end

  describe "with raw content" do
    let :component do
      Class.new Phlex::Component do
        def template
          _raw "<h1>Hi</h1>"
        end
      end
    end

    it "produces the correct output" do
      expect(output).to eq "<h1>Hi</h1>"
    end
  end

  describe "with whitespace" do
    let :component do
      Class.new Phlex::Component do
        def template
          a "Home"
          whitespace
          a "About"
        end
      end
    end

    it "produces the correct output" do
      expect(output).to eq "<a>Home</a> <a>About</a>"
    end
  end

  describe "with dangerous tag attributes" do
    let :component do
      Class.new Phlex::Component do
        def template
          article id: %{"><script type="text/javascript" src="bad_script.js"></script>}
        end
      end
    end

    it "escapes the attributes" do
      expect(output).to eq %{<article id="&quot;&gt;&lt;script type=&quot;text/javascript&quot; src=&quot;bad_script.js&quot;&gt;&lt;/script&gt;"></article>}
    end
  end

  describe "with dangerous content" do
    let :component do
      Class.new Phlex::Component do
        def template
          article %{"><script type="text/javascript" src="bad_script.js"></script>}
        end
      end
    end

    it "escapes the content" do
      expect(output).to eq %{<article>&quot;&gt;&lt;script type=&quot;text/javascript&quot; src=&quot;bad_script.js&quot;&gt;&lt;/script&gt;</article>}
    end
  end

  describe "with javascript link protocol in hypertext reference" do
    let :component do
      Class.new Phlex::Component do
        def template
          a "Javascript link", href: "javascript:javascript:alert(1)"
        end
      end
    end

    it "strips the javascript protocol" do
      expect(output).to have_tag :a, with: { href: "alert(1)" }
    end
  end

  describe "with a standard HTML element" do
    let :component do
      Class.new Phlex::Component do
        def template
          h1 "Hello", id: "foo"
        end
      end
    end

    it "produces the content" do
      expect(output).to have_tag :h1, text: "Hello"
    end

    it "produces the attributes" do
      expect(output).to have_tag :h1, with: { id: "foo" }
    end

    it "produces the correct markup" do
      expect(output).to eq %{<h1 id="foo">Hello</h1>}
    end
  end

  describe "with a void HTML element" do
    let :component do
      Class.new Phlex::Component do
        def template
          img src: "/logo.png", alt: "Logo"
        end
      end
    end

    it "produces the attributes" do
      expect(output).to have_tag :img, with: { src: "/logo.png", alt: "Logo" }
    end

    it "doesn't produce a closing tag" do
      expect(output).to end_with "/>"
    end

    it "produces the correct markup" do
      expect(output).to eq %{<img src="/logo.png" alt="Logo" />}
    end
  end

  describe "with nested tags" do
    let :component do
      Class.new Phlex::Component do
        def initialize
          @status = "done"
        end

        def template
          nav {
            ul {
              li @status
              li status_emoji
            }
          }
        end

        def status_emoji
          case @status
          when "done"
            "✅"
          end
        end
      end
    end

    it "captures instance methods" do
      expect(output).to have_tag "nav>ul>li", text: "✅"
    end

    it "captures instance variables" do
      expect(output).to have_tag "nav>ul>li", text: "done"
    end

    it "produces the correct markup" do
      expect(output).to eq %{<nav><ul><li>done</li><li>✅</li></ul></nav>}
    end
  end

  describe "with Emmet-style classes" do
    let :component do
      Class.new Phlex::Component do
        def template
          div.a.b.c.tap do
            h1.a.b.c "Hello", id: "foo"
          end
        end
      end
    end

    it "supports a wide variety of methods" do
      expect(output).to have_tag :div, with: { class: "tap" }
    end

    it "produces the block content" do
      expect(output).to have_tag "div>h1"
    end

    it "produces the text content" do
      expect(output).to have_tag :h1, text: "Hello"
    end

    it "produces the tag attributes" do
      expect(output).to have_tag :h1, with: { id: "foo" }
    end

    it "produces the correct markup" do
      expect(output).to eq %{<div class="a b c tap"><h1 id="foo" class="a b c">Hello</h1></div>}
    end
  end

  describe "with a String of classes" do
    let :component do
      Class.new Phlex::Component do
        def template
          div class: "a b c"
        end
      end
    end

    it "produces the classes" do
      expect(output).to eq %{<div class="a b c"></div>}
    end
  end

  describe "with an Array<String> of classes" do
    let :component do
      Class.new Phlex::Component do
        def template
          div class: %w(a b c)
        end
      end
    end

    it "produces the classes" do
      expect(output).to eq %{<div class="a b c"></div>}
    end
  end

  describe "with underscore in class name" do
    let :component do
      Class.new Phlex::Component do
        def template
          div class: "a_b"
        end
      end
    end

    describe "when default configuration used" do
      it "converts underscores to dashes and produces the classes" do
        expect(output).to eq %{<div class="a-b"></div>}
      end
    end

    describe "when configured convert_underscores_to_dashes to false" do
      around(:each) do |example|
        Phlex.configure { |config| config.convert_underscores_to_dashes = false }
        example.run
        Phlex.configure { |config| config.convert_underscores_to_dashes = true }
      end

      it "does not converts underscores to dashes and produces the classes" do
        expect(output).to eq %{<div class="a_b"></div>}
      end
    end
  end

  describe "with component attributes" do
    let :component do
      Class.new Phlex::Component do
        def initialize(title:)
          super
        end

        def template
          html { head { title @title } }
        end
      end
    end

    let(:example) { component.new(title: "Hello World") }

    it "produces the attributes" do
      expect(output).to have_tag "html>head>title", text: "Hello World"
    end
  end

  describe "rendering the same component twice" do
    let :component do
      Class.new Phlex::Component do
        def template
          h1 "Rendered twice"
        end
      end
    end

    it "raises an error" do
      instance = component.new

      expect { 2.times { instance.call } }.to raise_error("The same component instance shouldn't be rendered twice")
    end
  end

  describe "with a nested component" do
    describe "with nested content" do
      let :component do
        Class.new Phlex::Component do
          def initialize
            @status = "done"
          end

          def template
            main {
              component(CardComponent) {
                h1 @status
                h2 status_emoji
              }
            }
          end

          private

          def status_emoji
            case @status
            when "done"
              "✅"
            end
          end
        end
      end

      it "captures instance variables" do
        expect(output).to have_tag "main>article.drop-shadow>h1", text: "done"
      end

      it "captures instance methods" do
        expect(output).to have_tag "main>article.drop-shadow>h2", text: "✅"
      end

      it "produces the correct markup" do
        expect(output).to eq %{<main><article class="p-5 rounded drop-shadow"><h1>done</h1><h2>✅</h2></article></main>}
      end
    end

    describe "that isn't a component" do
      let :component do
        Class.new Phlex::Component do
          def template
            component Set
          end
        end
      end

      it "raises an ArgumentError" do
        expect { output }.to raise_error(ArgumentError, "Set isn't a Phlex::Component.")
      end
    end

    describe "with a template tag" do
      let :component do
        Class.new Phlex::Component do
          def template
            div do
              h1 "A"
              template "B"
              h2 "C"
            end
          end
        end
      end

      it "produces the correct markup" do
        expect(output).to eq "<div><h1>A</h1><template>B</template><h2>C</h2></div>"
      end
    end

    describe "with custom elements" do
      let :component do
        Class.new Phlex::Component do
          register_element :trix_editor, :trix_toolbar

          def template
            div {
              trix_toolbar
              trix_editor "Hello"
            }
          end
        end
      end

      it "produces the correct markup" do
        expect(output).to eq "<div><trix-toolbar></trix-toolbar><trix-editor>Hello</trix-editor></div>"
      end

      describe "with invalid tags" do
        let :component do
          Class.new Phlex::Component do
            register_element "NOT-VALID"
          end
        end

        it "raises an ArgumentError" do
          expect { component }.to raise_error(ArgumentError,
            "Custom elements must be provided as Symbols")
        end
      end
    end
  end

  describe "with a positional argument" do
    let(:component) do
      Class.new Phlex::Component do
        def template
          component CardComponent, "Hello World!"
        end
      end
    end

    it "produces the correct markup" do
      expect(output).to eq %{<article class="p-5 rounded drop-shadow">Hello World!</article>}
    end
  end

  describe "with Rails rendering" do
    describe "when passing the locals to render" do
      let(:component) do
        Class.new Phlex::Component do
          def template
            component CardComponent do
              render "content", locals: { name: "Alexandre" }
            end
          end
        end
      end

      it "produces the correct markup" do
        ActionView::Base.with_view_paths(File.expand_path("../../examples/partials", __dir__)) do
          expect(output).to eq %{<article class="p-5 rounded drop-shadow">Welcome Alexandre!</article>}
        end
      end
    end

    describe "when passing a model to render" do
      let(:component) do
        Class.new Phlex::Component do
          def template
            component CardComponent do
              render @article
            end
          end
        end
      end

      it "produces the correct markup" do
        @article = Article.new(title: "Phlex documentation")

        ActionView::Base.with_view_paths(File.expand_path("../../examples/partials", __dir__)) do
          expect(output).to eq %{<article class="p-5 rounded drop-shadow">Title: Phlex documentation</article>}
        end
      end
    end
  end
end
