require "test_helper"

module Phlex
  class TestComponent < Minitest::Test
    class MyComponent < Phlex::Component
      def template
        -> (content) { table(&content); }
      end
    end

    def test_it_works
      component = MyComponent.new { tr { td } }

      assert_equal "<table><tr><td></td></tr></table>", component.call
    end
  end
end
