# frozen_string_literal: true

Phlex::SVG::StandardElements.__registered_elements__.each do |method_name, tag|
	test "<#{tag}> with block text content and attributes" do
		example = Class.new(Phlex::SVG) do
			define_method :view_template do
				__send__(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
			end
		end

		assert_equal example.call, %(<#{tag} class="class" id="id" disabled>content</#{tag}>)
	end

	test "<#{tag}> with string attribute keys" do
		example = Class.new(Phlex::SVG) do
			define_method :view_template do
				__send__(method_name, "attribute_with_underscore" => true) { "content" }
			end
		end

		assert_equal example.call, %(<#{tag} attribute_with_underscore>content</#{tag}>)
	end

	test "<#{tag}> with hash attribute values" do
		example = Class.new(Phlex::SVG) do
			define_method :view_template do
				__send__(method_name, aria: { hidden: true }, data_turbo: { frame: "_top" }) { "content" }
			end
		end

		assert_equal example.call, %(<#{tag} aria-hidden data-turbo-frame="_top">content</#{tag}>)
	end
end
