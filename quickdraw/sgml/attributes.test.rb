# frozen_string_literal: true

test "class array attribute" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(class: ["class", nil, inactive: false, truthy: 1]) { "content" }
		end
	end

	expect(example.call) == %(<div class="class truthy">content</div>)
end

test "class hash attribute" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(class: { class: true, inactive: false, truthy: 1 }) { "content" }
		end
	end

	expect(example.call) == %(<div class="class truthy">content</div>)
end

test "style array attribute" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(style: ["color: red", nil, font_weight: "bold", opacity: 0]) { "content" }
		end
	end

	expect(example.call) == %(<div style="color: red;font-weight:bold;opacity:0;">content</div>)
end

test "style hash attribute" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(style: { color: "red", word_break: nil, font_weight: "bold" }) { "content" }
		end
	end

	expect(example.call) == %(<div style="color:red;font-weight:bold;">content</div>)
end

test "data attributes" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(data: { controller: "foo", turbo_action: :delete }) { "content" }
		end
	end

	expect(example.call) == %(<div data-controller="foo" data-turbo-action="delete">content</div>)
end

test "nil attributes" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(class: nil, style: nil, data: { controller: nil }) { "content" }
		end
	end

	expect(example.call) == %(<div>content</div>)
end

test "deeply nested attributes" do
	example = Class.new(Phlex::HTML) do
		def view_template
			div(data: { controller: "foo", foo: { comments_outlet: "#comments" } }) { "content" }
		end
	end

	expect(example.call) == %(<div data-controller="foo" data-foo-comments-outlet="#comments">content</div>)
end
