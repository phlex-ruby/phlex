require "test_helper"

module Phlex
  class TestComponent < Minitest::Test
    class SimpleComponent < Component
      def template(&content)
        div(&content)
      end
    end

    class ComponentWithImplicitAttributes < Component
      def template
        div @status
      end
    end

    class ComponentWithExplicitAttributes < Component
      def initialize(name)
        @name = name
      end

      def template
        div "Hello #{@name}"
      end
    end

    class Inception < Component
      def template
        h1 @dream

        component SimpleComponent do
          h1 @dream
        end
      end
    end

    class Template < Component
      def template(&content)
        super(&content)
      end
    end

    class Composition < Component
      def template(&content)
        title
        body(&content)
      end

      private

      def title
        dt { h2 @title }
      end

      def body(&content)
        dd(&content)
      end
    end

    def test_component_with_block_content
      component = SimpleComponent.new { ul { li "Hello" } }
      assert_equal '<div><ul><li>Hello</li></ul></div>', component.call
    end

    def test_component_with_implicit_attributes
      component = ComponentWithImplicitAttributes.new(status: "Hello")
      assert_equal '<div>Hello</div>', component.call
    end

    def test_component_with_explicit_attributes
      component = ComponentWithExplicitAttributes.new("Joel")
      assert_equal "<div>Hello Joel</div>", component.call
    end

    def test_assigns_are_passed_down
      component = Inception.new(dream: "😴")
      assert_equal "<h1>😴</h1><div><h1>😴</h1></div>", component.call
    end

    def test_component_with_template_tag
      component = Template.new { h1 "👋" }
      assert_equal "<template><h1>👋</h1></template>", component.call
    end

    def test_component_with_composition
      component = Composition.new(title: "Hello") do
        text "Hi"
      end

      assert_equal "<dt><h2>Hello</h2></dt><dd>Hi</dd>", component.call
    end
  end
end
