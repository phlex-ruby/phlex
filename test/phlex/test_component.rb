require "test_helper"

module Phlex
  class TestComponent < Minitest::Test
    class MyComponent < Component
      def initialize(status:)
        @status = status
      end

      def template(&block)
        ul do
          li "Hi"
          li emoji
          li @status
          render &block
        end
      end

      private

      def emoji
        case @status
        when :success
          "✅"
        when :failure
          "❌"
        end
      end
    end

    def test_it_works
      component = MyComponent.new(status: :success) do
        h1 "Hello"
        component MyComponent, status: :failure
      end
      assert_equal "<ul><li>Hi</li><h1>Hello</h1></ul>", component.call
    end
  end
end
