# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "with a standard tag" do
	expect(phlex { tag(:div) }) == %(<div></div>)
end

test "with a void tag" do
	expect(phlex { tag(:br) }) == %(<br>)
end

test "with a non-registered element" do
	expect(phlex { tag(:foo) }) == %(<foo></foo>)
end

test "with attributes" do
	expect(phlex { tag(:div, class: "hello") }) == %(<div class="hello"></div>)
end

test "with content" do
	expect(phlex { tag(:div) { "Hello, World!" } }) == %(<div>Hello, World!</div>)
end

test "with content and attributes" do
	expect(phlex { tag(:div, class: "hello") { "Hello, World!" } }) == %(<div class="hello">Hello, World!</div>)
end

test "with a non-registered element and attributes" do
	expect(phlex { tag(:foo, class: "hello") }) == %(<foo class="hello"></foo>)
end

test "with a non-registered element and content" do
	expect(phlex { tag(:foo) { "Hello, World!" } }) == %(<foo>Hello, World!</foo>)
end

test "with a non-registered element and content and attributes" do
	expect(phlex { tag(:foo, class: "hello") { "Hello, World!" } }) == %(<foo class="hello">Hello, World!</foo>)
end

test "with a script tag" do
	expect { phlex { tag(:script) } }.to_raise(Phlex::ArgumentError)
end

test "unsafe_tag with a script tag" do
	expect(phlex { unsafe_tag(:script) }) == %(<script></script>)
end

test "a symbol tag with an underscore" do
  expect(phlex { tag(:custom_element) }) == %(<custom-element></custom-element>)
end

test "a string tag with an underscore" do
	expect(phlex { tag("custom_element") }) == %(<custom-element></custom-element>)
end
