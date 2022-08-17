module Pages
  class Index < ApplicationPage
    include Components

    def template
      component Layout, title: "Introduction" do
        component Markdown, <<~MD
          # Getting started

          You can create a component class by subclassing `Phlex::Component` and defining a method called `template`. Within the template method, you can build up HTML markup by calling the name of any HTML tag.

          The first argument is the content. For example, here’s a component with an `<h1>` tag that says “Hello World!”
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
          ## Attributes

          Add attributes to HTML tags by passing keyword arguments to the tag method.
        MD

        component Example do |e|
          e.tab "heading_component.rb", <<~RUBY
            class HeadingComponent < Phlex::Component
              def template
                h1 "Hello World!", id: "main-heading", class: "text-xl font-bold"
              end
            end
          RUBY

          e.execute "HeadingComponent.new.call"
        end

        component Markdown, <<~MD
          You can also use *boolean* attributes (`true` or `false`).
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

          Pass a block to a tag to nest other elements inside it.
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
          ## Text

          You can also output text without wrapping it in a tag using the `text` method. All text content is HTML-escaped by default so it’s safe to use user input.
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
          ## The template tag

          Because the `template` method is used to define the component template, you need to use `template_tag` to render an HTML `<template>` tag.
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

        component Markdown, <<~MD
          ## Whitespace

          The examples here have been formatted for readability but by default, there is no whitespace between HTML tags. If you need to add some whitespace, you can use the `whitespace` method explicitly. This is useful for adding space between inline elements.
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
      end
    end
  end
end
