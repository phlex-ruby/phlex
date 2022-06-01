require "test_helper"

module Phlex
  class TestTag < Minitest::Test
    def test_standard_element
      tag = Tag::Table.new do
        tr.test do
          td "Hi"
        end
      end

      assert_equal '<table><tr class="test"><td>Hi</td></tr></table>', tag.call
    end

    def test_void_element
      tag = Tag::Img.new(href: "hero.jpg").hero.highlight

      assert_equal '<img href="hero.jpg" class="hero highlight" />', tag.call
    end
  end
end
