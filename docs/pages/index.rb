module Pages
  class Index < ApplicationPage
    def template
      component Layout, title: "Introduction" do
        component Markdown, <<~MD
          # Templates

          Rather than use another langauge like ERB, HAML or Slim, Phlex provides a Ruby DSL for defining HTML templates.

          You can create a component class by subclassing `Phlex::Component` and defining a method called `template`. Within the `template` method, you can compose HTML markup by calling the name of any [HTML element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element).

          The first argument to an HTML element method is the _text content_ for that element. For example, here’s a component with an `<h1>` element that says “Hello World!”
        MD

        component Example do |e|
          e.tab "heading_component.rb", <<~RUBY
            class HeadingComponent < Phlex::Component
              def template
                h1 "Hello World!"
              end
            end
          RUBY

          e.execute "HeadingComponent.new.call"
        end

        component Markdown, <<~MD
          The text content is always HTML-escaped, so it’s safe to use with user input.

          ## Attributes

          You can add attributes to HTML elements by passing keyword arguments to the tag method. Underscores (`_`) in attribute names are automatically converted to dashes (`-`).
        MD

        component Example do |e|
          e.tab "heading_component.rb", <<~RUBY
            class HeadingComponent < Phlex::Component
              def template
                h1 "Hello World!",
                  class: "text-xl font-bold",
                  aria_details: "details"
              end
            end
          RUBY

          e.execute "HeadingComponent.new.call"
        end

        component Markdown, <<~MD
          You can also use *boolean* attributes. When set to `true`, the attribute will be rendered without a value, when _falsy_, the attribute isn’t rendered at all.
        MD

        component Example do |e|
          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                input type: "radio", name: "channel", id: "1", checked: true
                input type: "radio", name: "channel", id: "2", checked: false
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end

        component Markdown, <<~MD
          ## Nesting

          Pass a block to an element method to nest other elements inside it.
        MD

        component Example do |e|
          e.tab "nav_component.rb", <<~RUBY
            class NavComponent < Phlex::Component
              def template
                nav do
                  ul do
                    li { a "Home", href: "/" }
                    li { a "About", href: "/about" }
                    li { a "Contact", href: "/contact" }
                  end
                end
              end
            end
          RUBY

          e.execute "NavComponent.new.call"
        end

        component Markdown, <<~MD
          ## Stand-alone text

          You can also output text without wrapping it in an element by using the `text` method. All text content is HTML-escaped, so it’s safe to use with user input.
        MD

        component Example do |e|
          e.tab "heading_component.rb", <<~RUBY
            class HeadingComponent < Phlex::Component
              def template
                h1 { strong "Hello "; text "World!" }
              end
            end
          RUBY

          e.execute "HeadingComponent.new.call"
        end

        component Markdown, <<~MD
          ## Whitespace

          While the examples on this page have been formatted for readability, there is usually no whitespace between HTML tags. If you need to add some whitespace, you can use the `whitespace` method. This is useful for adding space between _inline_ elements to allow them to wrap.
        MD

        component Example do |e|
          e.tab "example_component.rb", <<~RUBY
            class LinksComponent < Phlex::Component
              def template
                a "Home", href: "/"
                whitespace
                a "About", href: "/about"
                whitespace
                a "Contact", href: "/contact"
              end
            end
          RUBY

          e.execute "LinksComponent.new.call"
        end

        component Markdown, <<~MD
          ## The template element

          Because the `template` method is used to define the component template itself, you need to use the method `template_tag` if you want to to render an HTML `<template>` tag.
        MD

        component Example do |e|
          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                template_tag do
                  img src: "hidden.jpg", alt: "A hidden image."
                end
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end
      end
    end
  end
end
