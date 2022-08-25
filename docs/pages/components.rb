module Pages
  class Components < ApplicationPage
    def template
      render Layout.new(title: "Components in Phlex") do
        render Markdown.new(<<~MD)
          # Components

          ## Yielding content

          Your components can accept content as a block passed to the template method. You can capture the content block and pass it to the `content` method to yield it.
        MD

        render Example.new do |e|
          e.tab "card_component.rb", <<~RUBY
            class CardComponent < Phlex::Component
              def template(&)
                ARTICLE(class: "drop-shadow rounded p-5") {
                  H1 "Amazing content!"
                  content(&)
                }
              end
            end
          RUBY

          e.execute "CardComponent.new.call { 'Your content here.\n' }"
        end

        render Markdown.new(<<~MD)
          ## Delegating content

          Alternatively, you can pass the content down as an argument to another component or tag.
        MD

        render Example.new do |e|
          e.tab "card_component.rb", <<~RUBY
            class CardComponent < Phlex::Component
              def template(&)
                ARTICLE(class: "drop-shadow rounded p-5", &)
              end
            end
          RUBY

          e.execute "CardComponent.new.call { 'Your content here.' }"
        end

        render Markdown.new(<<~MD)
          ## Nested components

          Components can render other components and optionally pass them content as a block.
        MD

        render Example.new do |e|
          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                render CardComponent.new do
                  H1 "Hello"
                end
              end
            end
          RUBY

          e.tab "card_component.rb", <<~RUBY
            class CardComponent < Phlex::Component
              def template(&)
                ARTICLE(class: "drop-shadow rounded p-5", &)
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end

        render Markdown.new(<<~MD)
          If the block just wraps a string, the string is treated as _text content_.
        MD

        render Example.new do |e|
          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                render(CardComponent.new) { "Hi" }
              end
            end
          RUBY

          e.tab "card_component.rb", <<~RUBY
            class CardComponent < Phlex::Component
              def template(&)
                ARTICLE(class: "drop-shadow rounded p-5", &)
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end

        render Markdown.new(<<~MD)
          ## Component attributes

          Besides content, components can define attributes in an initializer, which can then be rendered in the template.
        MD

        render Example.new do |e|
          e.tab "hello_component.rb", <<~RUBY
            class HelloComponent < Phlex::Component
              def initialize(name:)
                @name = name
              end

              def template
                H1 "Hello \#{@name}!"
              end
            end
          RUBY

          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                render HelloComponent.new(name: "Joel")
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end

        render Markdown.new(<<~MD)
          The default initializer in `Phlex::Component` sets each given keyword argument to an instance variable, so the above could be re-written to call `super` instead.
        MD

        render Example.new do |e|
          e.tab "hello_component.rb", <<~RUBY
            class HelloComponent < Phlex::Component
              def initialize(name:)
                super
              end

              def template
                H1 "Hello \#{@name}!"
              end
            end
          RUBY

          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                render HelloComponent.new(name: "Joel")
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end

        render Markdown.new(<<~MD)
          It’s usually a good idea to use instance variables directly rather than creating accessor methods for them. Otherwise it’s easy to run into naming conflicts. For example, your layout component might have the attribute `title`, to render into a `<title>` element in the document head. If you define `attr_accessor :title`, that would overwrite the `title` method for creating `<title>` elements.

          ## Calculations with methods

          Components are just Ruby classes, so you can perform calculations on component attributes by defining your own methods.
        MD

        render Example.new do |e|
          e.tab "status_component.rb", <<~RUBY
            class StatusComponent < Phlex::Component
              def initialize(status:)
                super
              end

              def template
                SPAN status_emoji
              end

              private

              def status_emoji
                case @status
                when :success
                  "✅"
                when :failure
                  "❌"
                end
              end
            end
          RUBY

          e.tab "example_component.rb", <<~RUBY
            class ExampleComponent < Phlex::Component
              def template
                render StatusComponent.new(status: :success)
              end
            end
          RUBY

          e.execute "ExampleComponent.new.call"
        end
      end
    end
  end
end
