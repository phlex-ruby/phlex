require "test_helper"

module Phlex
  class TestComponent < Minitest::Test
    class MyComponent < Phlex::Component
      template do |content, title|
        table do
          h1 title
          render &content
        end
      end
    end

    def test_it_works
      component = MyComponent.new("Joel") { tr { td } }

      assert_equal "<table><h1>Joel</h1><tr><td></td></tr></table>", component.call
    end
  end
end
