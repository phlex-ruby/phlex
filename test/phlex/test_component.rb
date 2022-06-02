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
      component = MyComponent.new(status: :success)
      assert_equal "<ul><li>Hi</li></ul>", component.call
    end
  end
end
