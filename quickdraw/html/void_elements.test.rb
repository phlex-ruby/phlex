# frozen_string_literal: true

Phlex::HTML::VoidElements.__registered_elements__.each do |method_name, tag|
	test "<#{tag}> called with an underscore prefix while overridden" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__("_#{method_name}")
			end

			define_method tag do
				super(class: "overridden")
			end
		end

		expect(example.call) == %(<#{tag}>)
	end

	test "<#{tag}> with attributes" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, class: "class", id: "id", disabled: true, selected: false)
			end
		end

		expect(example.call) == %(<#{tag} class="class" id="id" disabled>)
	end

	test "<#{tag}> with string attribute keys" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, "attribute_with_underscore" => true)
			end
		end

		expect(example.call) == %(<#{tag} attribute_with_underscore>)
	end

	test "<#{tag}> with hash attribute values" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" })
			end
		end

		expect(example.call) == %(<#{tag} aria-hidden data-turbo-frame="_top">)
	end
end
