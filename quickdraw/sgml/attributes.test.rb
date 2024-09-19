# frozen_string_literal: true

def div(**attributes)
	Phlex::HTML.new.call do |e|
		e.div(**attributes)
	end
end

test "id attributes must be lower case symbols" do
	expect {
		div("id" => "abc")
	}.to_raise(Phlex::ArgumentError)

	expect {
		div("ID" => "abc")
	}.to_raise(Phlex::ArgumentError)

	expect {
		div(:ID => "abc")
	}.to_raise(Phlex::ArgumentError)

	expect(
		div(id: "abc"),
	) == %(<div id="abc"></div>)
end

test "[invalid], _" do
	expect {
		div(Object.new => "abc")
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Attribute keys should be Strings or Symbols."
	end
end

test "unsafe event attribute" do
	expect {
		div("onclick" => true)
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: onclick."
	end
end

test "unsafe href attribute" do
	expect(
		div(href: "javascript:alert('hello')"),
	) == %(<div></div>)

	expect(
		div(href: "Javascript:alert('hello')"),
	) == %(<div></div>)

	expect(
		div("href" => "javascript:alert('hello')"),
	) == %(<div></div>)

	expect(
		div("Href" => "javascript:alert('hello')"),
	) == %(<div></div>)

	expect(
		div("Href" => "javascript:javascript:alert('hello')"),
	) == %(<div></div>)

	expect(
		div(href: " \t\njavascript:alert('hello')"),
	) == %(<div></div>)
end

test "unsafe attribute name with escape characters" do
	expect {
		div("<" => true)
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: <."
	end

	expect {
		div(">" => true)
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: >."
	end

	expect {
		div("&" => true)
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: &."
	end

	expect {
		div("'" => true)
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: '."
	end

	expect {
		div('"' => true)
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Unsafe attribute name detected: \"."
	end
end

test "_, nil" do
	expect(
		div(attribute: nil),
	) == %(<div></div>)
end

test "_, true" do
	expect(
		div(attribute: true),
	) == %(<div attribute></div>)
end

test "_, false" do
	expect(
		div(attribute: false),
	) == %(<div></div>)
end

test "_, String" do
	expect(
		div(attribute: ""),
	) == %(<div attribute=""></div>)

	expect(
		div(attribute: "test"),
	) == %(<div attribute="test"></div>)

	expect(
		div(attribute: "with_underscores"),
	) == %(<div attribute="with_underscores"></div>)

	expect(
		div(attribute: "with-dashes"),
	) == %(<div attribute="with-dashes"></div>)

	expect(
		div(attribute: "with spaces"),
	) == %(<div attribute="with spaces"></div>)

	expect(
		div(attribute: "with 'single quotes'"),
	) == %(<div attribute="with 'single quotes'"></div>)

	expect(
		div(attribute: "with <html>"),
	) == %(<div attribute="with <html>"></div>)

	expect(
		div(attribute: 'with "double quotes"'),
	) == %(<div attribute="with &quot;double quotes&quot;"></div>)
end

test "_, Symbol" do
	expect(
		div(attribute: :""),
	) == %(<div attribute=""></div>)

	expect(
		div(attribute: :test),
	) == %(<div attribute="test"></div>)

	expect(
		div(attribute: :with_underscores),
	) == %(<div attribute="with-underscores"></div>)

	expect(
		div(attribute: :"with-dashes"),
	) == %(<div attribute="with-dashes"></div>)

	expect(
		div(attribute: :"with spaces"),
	) == %(<div attribute="with spaces"></div>)

	expect(
		div(attribute: :"with 'single quotes'"),
	) == %(<div attribute="with 'single quotes'"></div>)

	expect(
		div(attribute: :"with <html>"),
	) == %(<div attribute="with <html>"></div>)

	expect(
		div(attribute: :'with "double quotes"'),
	) == %(<div attribute="with &quot;double quotes&quot;"></div>)
end

test "_, Integer" do
	expect(
		div(attribute: 0),
	) == %(<div attribute="0"></div>)

	expect(
		div(attribute: 42),
	) == %(<div attribute="42"></div>)
end

test "_, Float" do
	expect(
		div(attribute: 0.0),
	) == %(<div attribute="0.0"></div>)

	expect(
		div(attribute: 42.0),
	) == %(<div attribute="42.0"></div>)

	expect(
		div(attribute: 1.234),
	) == %(<div attribute="1.234"></div>)
end

test "_, Array" do
	expect(
		div(attribute: []),
	) == %(<div attribute=""></div>)
end

test "_, Array(nil)" do
	expect(
		div(attribute: [nil, nil, nil]),
	) == %(<div attribute=""></div>)
end

test "_, Array(String)" do
	expect(
		div(attribute: ["Hello", "World"]),
	) == %(<div attribute="Hello World"></div>)

	expect(
		div(attribute: ["with_underscores", "with-dashes", "with spaces"]),
	) == %(<div attribute="with_underscores with-dashes with spaces"></div>)

	expect(
		div(attribute: ["with 'single quotes'", 'with "double quotes"']),
	) == %(<div attribute="with 'single quotes' with &quot;double quotes&quot;"></div>)
end

test "_, Array(Symbol)" do
	expect(
		div(attribute: [:hello, :world]),
	) == %(<div attribute="hello world"></div>)

	expect(
		div(attribute: [:with_underscores, :"with-dashes", :"with spaces"]),
	) == %(<div attribute="with-underscores with-dashes with spaces"></div>)

	expect(
		div(attribute: [:with, :"single quotes", :'"double quotes"']),
	) == %(<div attribute="with single quotes &quot;double quotes&quot;"></div>)
end

test "_, Array(Integer)" do
	expect(
		div(attribute: [0, 42]),
	) == %(<div attribute="0 42"></div>)
end

test "_, Array(Float)" do
	expect(
		div(attribute: [0.0, 42.0, 1.234]),
	) == %(<div attribute="0.0 42.0 1.234"></div>)
end

test "_, Array(Phlex::SGML::SafeObject)" do
	expect(
		div(attribute: [
			Phlex::SGML::SafeValue.new("Hello"),
		]),
	) == %(<div attribute="Hello"></div>)
end

test "_, Array([invalid])" do
	expect {
		div(attribute: [Object.new])
	}.to_raise(Phlex::ArgumentError)
end

test "_, Set(nil)" do
	expect(
		div(attribute: Set[nil, nil, nil]),
	) == %(<div attribute=""></div>)
end

test "_, Set(String)" do
	expect(
		div(attribute: Set["Hello", "World"]),
	) == %(<div attribute="Hello World"></div>)

	expect(
		div(attribute: Set["with_underscores", "with-dashes", "with spaces"]),
	) == %(<div attribute="with_underscores with-dashes with spaces"></div>)

	expect(
		div(attribute: Set["with 'single quotes'", 'with "double quotes"']),
	) == %(<div attribute="with 'single quotes' with &quot;double quotes&quot;"></div>)
end

test "_, Set(Symbol)" do
	expect(
		div(attribute: Set[:hello, :world]),
	) == %(<div attribute="hello world"></div>)

	expect(
		div(attribute: Set[:with_underscores, :"with-dashes", :"with spaces"]),
	) == %(<div attribute="with-underscores with-dashes with spaces"></div>)

	expect(
		div(attribute: Set[:with, :"single quotes", :'"double quotes"']),
	) == %(<div attribute="with single quotes &quot;double quotes&quot;"></div>)
end

test "_, Set(Integer)" do
	expect(
		div(attribute: Set[0, 42]),
	) == %(<div attribute="0 42"></div>)
end

test "_, Set(Float)" do
	expect(
		div(attribute: Set[0.0, 42.0, 1.234]),
	) == %(<div attribute="0.0 42.0 1.234"></div>)
end

test "_, Set(Phlex::SGML::SafeObject)" do
	expect(
		div(attribute: Set[
			Phlex::SGML::SafeValue.new("Hello"),
		]),
	) == %(<div attribute="Hello"></div>)
end

test "_, Set([invalid])" do
	expect {
		div(attribute: Set[Object.new])
	}.to_raise(Phlex::ArgumentError)
end

test ":style, Array(nil)" do
	expect(
		div(style: [nil, nil, nil]),
	) == %(<div style=""></div>)
end

test ":style, Array(Symbol)" do
	expect {
		div(style: [:color_blue])
	}.to_raise(Phlex::ArgumentError)
end

test ":style, Array(String)" do
	expect(
		div(style: ["color: blue;", "font-weight: bold"]),
	) == %(<div style="color: blue; font-weight: bold;"></div>)

	expect(
		div(style: ["font-family: 'MonoLisa'"]),
	) == %(<div style="font-family: 'MonoLisa';"></div>)

	expect(
		div(style: ['font-family: "MonoLisa"']),
	) == %(<div style="font-family: &quot;MonoLisa&quot;;"></div>)
end

test ":style, Array(Phlex::SGML::SafeObject)" do
	expect(
		div(style: [Phlex::SGML::SafeValue.new("color: blue")]),
	) == %(<div style="color: blue;"></div>)

	expect(
		div(style: [Phlex::SGML::SafeValue.new("font-weight: bold;")]),
	) == %(<div style="font-weight: bold;"></div>)
end

test ":style, Array(Hash)" do
	expect(
		div(style: [{ color: "blue" }, { font_weight: "bold", line_height: 1.5 }]),
	) == %(<div style="color: blue; font-weight: bold; line-height: 1.5;"></div>)
end

test ":style, Hash(Symbol, String)" do
	expect(
		div(style: { color: "blue", font_weight: "bold" }),
	) == %(<div style="color: blue; font-weight: bold;"></div>)
end

test ":style, Hash(Symbol, Integer)" do
	expect(
		div(style: { line_height: 2 }),
	) == %(<div style="line-height: 2;"></div>)
end

test ":style, Hash(Symbol, Float)" do
	expect(
		div(style: { line_height: 1.5 }),
	) == %(<div style="line-height: 1.5;"></div>)
end

test ":style, Hash(Symbol, Symbol)" do
	expect(
		div(style: { flex_direction: :column_reverse }),
	) == %(<div style="flex-direction: column-reverse;"></div>)

	expect(
		div(style: { flex_direction: :'"double quotes"' }),
	) == %(<div style="flex-direction: &quot;double quotes&quot;;"></div>)
end

test ":style, Hash(Symbol, Phlex::SGML::SafeObject)" do
	expect(
		div(style: { color: Phlex::SGML::SafeValue.new("blue") }),
	) == %(<div style="color: blue;"></div>)
end
