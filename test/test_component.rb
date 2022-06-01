require "test_helper"

class TestComponent < Minitest::Test
  def test_it_works
    context = Phlex::Context.new do
      table "Hi"
    end

    assert_equal "<table>Hi</table>", context.build
  end
end
