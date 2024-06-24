# frozen_string_literal: true

Phlex::HTML::StandardElements.registered_elements.each do |method_name, tag|
	describe "<#{tag}> called with an underscore prefix while overridden" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__("_#{method_name}")
			end

			define_method method_name do
				super(class: "overridden")
			end
		end

		test "is not overridden" do
			expect(example.call) == %(<#{tag}></#{tag}>)
		end
	end

	describe "<#{tag}> with block content and attributes" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} class="class" id="id" disabled><h1>Hello</h1></#{tag}>)
		end
	end

	describe "<#{tag}> with block text content and attributes" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} class="class" id="id" disabled>content</#{tag}>)
		end
	end

	describe "<#{tag}> with string attribute keys" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, "attribute_with_underscore" => true) { "content" }
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} attribute_with_underscore>content</#{tag}>)
		end
	end

	describe "<#{tag}> with hash attribute values" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" }) { "content" }
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} aria-hidden data-turbo-frame="_top">content</#{tag}>)
		end
	end
end

Phlex::HTML::VoidElements.registered_elements.each do |method_name, tag|
	describe "<#{tag}> called with an underscore prefix while overridden" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__("_#{method_name}")
			end

			define_method tag do
				super(class: "overridden")
			end
		end

		test "is not overridden" do
			expect(example.call) == %(<#{tag}>)
		end
	end

	describe "<#{tag}> with attributes" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, class: "class", id: "id", disabled: true, selected: false)
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} class="class" id="id" disabled>)
		end
	end

	describe "<#{tag}> with string attribute keys" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, "attribute_with_underscore" => true)
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} attribute_with_underscore>)
		end
	end

	describe "<#{tag}> with hash attribute values" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" })
			end
		end

		test "produces the correct output" do
			expect(example.call) == %(<#{tag} aria-hidden data-turbo-frame="_top">)
		end
	end
end
