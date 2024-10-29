# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "id attributes must be lower case symbols" do
	expect { phlex { div("id" => "abc") } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div("ID" => "abc") } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(:ID => "abc") } }.to_raise(Phlex::ArgumentError)

	expect(
		phlex { div(id: "abc") },
	) == %(<div id="abc"></div>)
end

test "*invalid*, _" do
	expect { phlex { div(Object.new => "abc") } }.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Attribute keys should be Strings or Symbols."
	end
end

test "unsafe event attribute" do
	expect { phlex { div("onclick" => true) } }.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: onclick."
	end
end

test "href with hash" do
	expect {
		phlex { a(href: {}) }
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Invalid attribute value for href: #{{}.inspect}."
	end
end

test "unsafe href attribute" do
	expect(
		phlex { div(href: "javascript:alert('hello')") },
	) == %(<div></div>)

	expect(
		phlex { div(href: "Javascript:alert('hello')") },
	) == %(<div></div>)

	expect(
		phlex { div("href" => "javascript:alert('hello')") },
	) == %(<div></div>)

	expect(
		phlex { div("Href" => "javascript:alert('hello')") },
	) == %(<div></div>)

	expect(
		phlex { div("Href" => "javascript:javascript:alert('hello')") },
	) == %(<div></div>)

	expect(
		phlex { div(href: " \t\njavascript:alert('hello')") },
	) == %(<div></div>)
end

test "unsafe attribute name with escape characters" do
	expect {
		phlex { div("<" => true) }
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: <."
	end

	expect {
		phlex { div(">" => true) }
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: >."
	end

	expect {
		phlex { div("&" => true) }
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: &."
	end

	expect {
		phlex { div("'" => true) }
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: '."
	end

	expect {
		phlex { div('"' => true) }
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: \"."
	end
end

test "_, nil" do
	expect(
		phlex { div(attribute: nil) },
	) == %(<div></div>)
end

test "_, true" do
	expect(
		phlex { div(attribute: true) },
	) == %(<div attribute></div>)
end

test "_, false" do
	expect(
		phlex { div(attribute: false) },
	) == %(<div></div>)
end

test "_, String" do
	expect(
		phlex { div(attribute: "") },
	) == %(<div attribute=""></div>)

	expect(
		phlex { div(attribute: "test") },
	) == %(<div attribute="test"></div>)

	expect(
		phlex { div(attribute: "with_underscores") },
	) == %(<div attribute="with_underscores"></div>)

	expect(
		phlex { div(attribute: "with-dashes") },
	) == %(<div attribute="with-dashes"></div>)

	expect(
		phlex { div(attribute: "with spaces") },
	) == %(<div attribute="with spaces"></div>)

	expect(
		phlex { div(attribute: "with 'single quotes'") },
	) == %(<div attribute="with 'single quotes'"></div>)

	expect(
		phlex { div(attribute: "with <html>") },
	) == %(<div attribute="with <html>"></div>)

	expect(
		phlex { div(attribute: 'with "double quotes"') },
	) == %(<div attribute="with &quot;double quotes&quot;"></div>)
end

test "_, Symbol" do
	expect(
		phlex { div(attribute: :"") },
	) == %(<div attribute=""></div>)

	expect(
		phlex { div(attribute: :test) },
	) == %(<div attribute="test"></div>)

	expect(
		phlex { div(attribute: :with_underscores) },
	) == %(<div attribute="with-underscores"></div>)

	expect(
		phlex { div(attribute: :"with-dashes") },
	) == %(<div attribute="with-dashes"></div>)

	expect(
		phlex { div(attribute: :"with spaces") },
	) == %(<div attribute="with spaces"></div>)

	expect(
		phlex { div(attribute: :"with 'single quotes'") },
	) == %(<div attribute="with 'single quotes'"></div>)

	expect(
		phlex { div(attribute: :"with <html>") },
	) == %(<div attribute="with <html>"></div>)

	expect(
		phlex { div(attribute: :'with "double quotes"') },
	) == %(<div attribute="with &quot;double quotes&quot;"></div>)
end

test "_, Integer" do
	expect(
		phlex { div(attribute: 0) },
	) == %(<div attribute="0"></div>)

	expect(
		phlex { div(attribute: 42) },
	) == %(<div attribute="42"></div>)
end

test "_, Float" do
	expect(
		phlex { div(attribute: 0.0) },
	) == %(<div attribute="0.0"></div>)

	expect(
		phlex { div(attribute: 42.0) },
	) == %(<div attribute="42.0"></div>)

	expect(
		phlex { div(attribute: 1.234) },
	) == %(<div attribute="1.234"></div>)
end

test "_, *invalid*" do
	expect {
		phlex { div(attribute: Object.new) }
	}.to_raise(Phlex::ArgumentError)
end

test "_, Array" do
	expect(
		phlex { div(attribute: []) },
	) == %(<div attribute=""></div>)
end

test "_, Array(nil)" do
	expect(
		phlex { div(attribute: [nil, nil, nil]) },
	) == %(<div attribute=""></div>)
end

test "_, Array(String)" do
	expect(
		phlex { div(attribute: ["Hello", "World"]) },
	) == %(<div attribute="Hello World"></div>)

	expect(
		phlex { div(attribute: ["with_underscores", "with-dashes", "with spaces"]) },
	) == %(<div attribute="with_underscores with-dashes with spaces"></div>)

	expect(
		phlex { div(attribute: ["with 'single quotes'", 'with "double quotes"']) },
	) == %(<div attribute="with 'single quotes' with &quot;double quotes&quot;"></div>)
end

test "_, Array(Symbol)" do
	expect(
		phlex { div(attribute: [:hello, :world]) },
	) == %(<div attribute="hello world"></div>)

	expect(
		phlex { div(attribute: [:with_underscores, :"with-dashes", :"with spaces"]) },
	) == %(<div attribute="with-underscores with-dashes with spaces"></div>)

	expect(
		phlex { div(attribute: [:with, :"single quotes", :'"double quotes"']) },
	) == %(<div attribute="with single quotes &quot;double quotes&quot;"></div>)
end

test "_, Array(Integer)" do
	expect(
		phlex { div(attribute: [0, 42]) },
	) == %(<div attribute="0 42"></div>)
end

test "_, Array(Float)" do
	expect(
		phlex { div(attribute: [0.0, 42.0, 1.234]) },
	) == %(<div attribute="0.0 42.0 1.234"></div>)
end

test "_, Array(Phlex::SGML::SafeObject)" do
	expect(
		phlex { div(attribute: [Phlex::SGML::SafeValue.new("Hello")]) },
	) == %(<div attribute="Hello"></div>)
end

test "_, Array(String | Array)" do
	expect(
		phlex { div(attribute: ["hello", ["world"]]) },
	) == %(<div attribute="hello world"></div>)
end

test "_, Array(Array | String)" do
	expect(
		phlex { div(attribute: [["hello"], "world"]) },
	) == %(<div attribute="hello world"></div>)
end

test "_, Array(String | EmptyArray)" do
	expect(
		phlex { div(attribute: ["hello", []]) },
	) == %(<div attribute="hello"></div>)
end

test "_, Array(*invalid*)" do
	expect {
		phlex { div(attribute: [Object.new]) }
	}.to_raise(Phlex::ArgumentError)
end

test "_, Hash(Symbol, _)" do
	expect(
		phlex { div(attribute: { a_b_c: "world" }) },
	) == %(<div attribute-a-b-c="world"></div>)

	expect { phlex { div(attribute: { :'"' => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { :"'" => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { :"&" => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { :"<" => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { :">" => "a" }) } }.to_raise(Phlex::ArgumentError)
end

test "_, Hash(String, _)" do
	expect(
		phlex { div(attribute: { "a_b_c" => "world" }) },
	) == %(<div attribute-a_b_c="world"></div>)

	expect { phlex { div(attribute: { '"' => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { "'" => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { "&" => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { "<" => "a" }) } }.to_raise(Phlex::ArgumentError)
	expect { phlex { div(attribute: { ">" => "a" }) } }.to_raise(Phlex::ArgumentError)
end

test "_, Hash(*invalid*, _)" do
	expect { phlex { div(attribute: { Object.new => "a" }) } }.to_raise(Phlex::ArgumentError)
end

test "_, Hash(_, String)" do
	expect(
		phlex { div(data: { controller: "with_underscores" }) },
	) == %(<div data-controller="with_underscores"></div>)

	expect(
		phlex { div(data: { controller: "with-dashes" }) },
	) == %(<div data-controller="with-dashes"></div>)

	expect(
		phlex { div(data: { controller: "with spaces" }) },
	) == %(<div data-controller="with spaces"></div>)

	expect(
		phlex { div(data: { controller: "with 'single quotes'" }) },
	) == %(<div data-controller="with 'single quotes'"></div>)

	expect(
		phlex { div(data: { controller: "with <html>" }) },
	) == %(<div data-controller="with <html>"></div>)

	expect(
		phlex { div(data: { controller: 'with "double quotes"' }) },
	) == %(<div data-controller="with &quot;double quotes&quot;"></div>)
end

test "_, Hash(_, Symbol)" do
	expect(
		phlex { div(data: { controller: :with_underscores }) },
	) == %(<div data-controller="with-underscores"></div>)

	expect(
		phlex { div(data: { controller: :"with-dashes" }) },
	) == %(<div data-controller="with-dashes"></div>)

	expect(
		phlex { div(data: { controller: :"with spaces" }) },
	) == %(<div data-controller="with spaces"></div>)

	expect(
		phlex { div(data: { controller: :"with 'single quotes'" }) },
	) == %(<div data-controller="with 'single quotes'"></div>)

	expect(
		phlex { div(data: { controller: :"with <html>" }) },
	) == %(<div data-controller="with <html>"></div>)

	expect(
		phlex { div(data: { controller: :'with "double quotes"' }) },
	) == %(<div data-controller="with &quot;double quotes&quot;"></div>)
end

test "_, Hash(_, Integer)" do
	expect(
		phlex { div(data: { controller: 42 }) },
	) == %(<div data-controller="42"></div>)

	expect(
		phlex { div(data: { controller: 1_234 }) },
	) == %(<div data-controller="1234"></div>)

	expect(
		phlex { div(data: { controller: 0 }) },
	) == %(<div data-controller="0"></div>)
end

test "_, Hash(_, Float)" do
	expect(
		phlex { div(data: { controller: 42.0 }) },
	) == %(<div data-controller="42.0"></div>)

	expect(
		phlex { div(data: { controller: 1.234 }) },
	) == %(<div data-controller="1.234"></div>)

	expect(
		phlex { div(data: { controller: 0.0 }) },
	) == %(<div data-controller="0.0"></div>)
end

test "_, Hash(_, Array)" do
	expect(
		phlex { div(data: { controller: [1, 2, 3] }) },
	) == %(<div data-controller="1 2 3"></div>)
end

test "_, Hash(_, Set)" do
	expect(
		phlex { div(data: { controller: Set[1, 2, 3] }) },
	) == %(<div data-controller="1 2 3"></div>)
end

test "_, Hash(_, Hash)" do
	expect(
		phlex { div(data: { controller: { hello: "world" } }) },
	) == %(<div data-controller-hello="world"></div>)
end

test "_, Hash(_, Phlex::SGML::SafeObject)" do
	expect(
		phlex { div(data: { controller: Phlex::SGML::SafeValue.new("Hello") }) },
	) == %(<div data-controller="Hello"></div>)
end

test "_, Hash(_, false)" do
	expect(
		phlex { div(data: { controller: false }) },
	) == %(<div></div>)
end

test "_, Hash(_, nil)" do
	expect(
		phlex { div(data: { controller: nil }) },
	) == %(<div></div>)
end

test "_, Hash(_, *invalid*)" do
	expect {
		phlex { div(data: { controller: Object.new }) }
	}.to_raise(Phlex::ArgumentError)
end

test "_, Set(nil)" do
	expect(
		phlex { div(attribute: Set[nil, nil, nil]) },
	) == %(<div attribute=""></div>)
end

test "_, Set(String)" do
	expect(
		phlex { div(attribute: Set["Hello", "World"]) },
	) == %(<div attribute="Hello World"></div>)

	expect(
		phlex { div(attribute: Set["with_underscores", "with-dashes", "with spaces"]) },
	) == %(<div attribute="with_underscores with-dashes with spaces"></div>)

	expect(
		phlex { div(attribute: Set["with 'single quotes'", 'with "double quotes"']) },
	) == %(<div attribute="with 'single quotes' with &quot;double quotes&quot;"></div>)
end

test "_, Set(Symbol)" do
	expect(
		phlex { div(attribute: Set[:hello, :world]) },
	) == %(<div attribute="hello world"></div>)

	expect(
		phlex { div(attribute: Set[:with_underscores, :"with-dashes", :"with spaces"]) },
	) == %(<div attribute="with-underscores with-dashes with spaces"></div>)

	expect(
		phlex { div(attribute: Set[:with, :"single quotes", :'"double quotes"']) },
	) == %(<div attribute="with single quotes &quot;double quotes&quot;"></div>)
end

test "_, Set(Integer)" do
	expect(
		phlex { div(attribute: Set[0, 42]) },
	) == %(<div attribute="0 42"></div>)
end

test "_, Set(Float)" do
	expect(
		phlex { div(attribute: Set[0.0, 42.0, 1.234]) },
	) == %(<div attribute="0.0 42.0 1.234"></div>)
end

test "_, Set(Phlex::SGML::SafeObject)" do
	expect(
		phlex {
			div(attribute: Set[
			Phlex::SGML::SafeValue.new("Hello"),
		])
		},
	) == %(<div attribute="Hello"></div>)
end

test "_, Set(*invalid*)" do
	expect {
		phlex { div(attribute: Set[Object.new]) }
	}.to_raise(Phlex::ArgumentError)
end

test ":style, Array(nil)" do
	expect(
		phlex { div(style: [nil, nil, nil]) },
	) == %(<div style=""></div>)
end

test ":style, Array(Symbol)" do
	expect {
		phlex { div(style: [:color_blue]) }
	}.to_raise(Phlex::ArgumentError)
end

test ":style, Array(String)" do
	expect(
		phlex { div(style: ["color: blue;", "font-weight: bold"]) },
	) == %(<div style="color: blue; font-weight: bold;"></div>)

	expect(
		phlex { div(style: ["font-family: 'MonoLisa'"]) },
	) == %(<div style="font-family: 'MonoLisa';"></div>)

	expect(
		phlex { div(style: ['font-family: "MonoLisa"']) },
	) == %(<div style="font-family: &quot;MonoLisa&quot;;"></div>)
end

test ":style, Array(Phlex::SGML::SafeObject)" do
	expect(
		phlex { div(style: [Phlex::SGML::SafeValue.new("color: blue")]) },
	) == %(<div style="color: blue;"></div>)

	expect(
		phlex { div(style: [Phlex::SGML::SafeValue.new("font-weight: bold;")]) },
	) == %(<div style="font-weight: bold;"></div>)
end

test ":style, Array(Hash)" do
	expect(
		phlex { div(style: [{ color: "blue" }, { font_weight: "bold", line_height: 1.5 }]) },
	) == %(<div style="color: blue; font-weight: bold; line-height: 1.5;"></div>)
end

test ":style, Set(nil)" do
	expect(
		phlex { div(style: Set[nil]) },
	) == %(<div style=""></div>)
end

test ":style, Set(String)" do
	expect(
		phlex { div(style: Set["color: blue"]) },
	) == %(<div style="color: blue;"></div>)
end

test ":style, Hash(Symbol, String)" do
	expect(
		phlex { div(style: { color: "blue", font_weight: "bold" }) },
	) == %(<div style="color: blue; font-weight: bold;"></div>)
end

test ":style, Hash(Symbol, Integer)" do
	expect(
		phlex { div(style: { line_height: 2 }) },
	) == %(<div style="line-height: 2;"></div>)
end

test ":style, Hash(Symbol, Float)" do
	expect(
		phlex { div(style: { line_height: 1.5 }) },
	) == %(<div style="line-height: 1.5;"></div>)
end

test ":style, Hash(Symbol, Symbol)" do
	expect(
		phlex { div(style: { flex_direction: :column_reverse }) },
	) == %(<div style="flex-direction: column-reverse;"></div>)

	expect(
		phlex { div(style: { flex_direction: :'"double quotes"' }) },
	) == %(<div style="flex-direction: &quot;double quotes&quot;;"></div>)
end

test ":style, Hash(Symbol, Phlex::SGML::SafeObject)" do
	expect(
		phlex { div(style: { color: Phlex::SGML::SafeValue.new("blue") }) },
	) == %(<div style="color: blue;"></div>)
end

test ":style, Hash(Symbol, nil)" do
	expect(
		phlex { div(style: { color: nil }) },
	) == %(<div style=""></div>)
end

test ":style, Hash(Symbol, *invalid*)" do
	expect {
		phlex { div(style: { color: Object.new }) }
	}.to_raise(Phlex::ArgumentError)
end

test ":style, Hash(String, String)" do
	expect(
		phlex { div(style: { "color" => "blue" }) },
	) == %(<div style="color: blue;"></div>)
end

test ":style, Hash(*invalid*, String)" do
	expect {
		phlex { div(style: { Object.new => "blue" }) }
	}.to_raise(Phlex::ArgumentError)
end

# This is just for coverage.
Phlex::HTML.call do |c|
	c.__send__(:__styles__, nil)
end
