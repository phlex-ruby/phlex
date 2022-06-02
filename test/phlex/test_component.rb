require "test_helper"

module Phlex
  class TestComponent < Minitest::Test
    class Table < Component
      def template(&block)
        table do
          render &block
        end
      end
    end

    class MyComponent < Component
      def initialize(status:)
        @status = status
      end

      def template(&block)
        ul do
          @status.each do |s|
            component Table do
              h1 s
              h2 @status
            end
          end
        end
      end

      private

      def emoji
        case @status
        when :success
          "✅"
        when :failure
          "❌"
        else
          "🤷"
        end
      end
    end

    def test_it_works
      component = MyComponent.new(status: [1, 2, 3])
      assert_equal '<ul><li>Hi</li><li>✅</li><li>success</li><h1>Hello</h1><ul><li>Hi</li><li>❌</li><li>failure</li><img href="/cat.jpg" /></ul><img href="/cat.jpg" /></ul>', component.call
    end
  end
end
