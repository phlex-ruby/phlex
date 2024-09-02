# frozen_string_literal: true

{ div: "div" }.each do |method_name, tag|
	test "<#{tag}> with class array attribute" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, class: ["class", nil, inactive: false, truthy: 1]) { "content" }
			end
		end

		expect(example.call) == %(<#{tag} class="class truthy">content</#{tag}>)
	end

	test "<#{tag}> with class hash attribute" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, class: { class: true, inactive: false, truthy: 1 }) { "content" }
			end
		end

		expect(example.call) == %(<#{tag} class="class truthy">content</#{tag}>)
	end

	test "<#{tag}> with style array attribute" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, style: ["color: red", nil, font_weight: "bold", opacity: 0]) { "content" }
			end
		end

		expect(example.call) == %(<#{tag} style="color: red;font-weight:bold;opacity:0;">content</#{tag}>)
	end

	test "<#{tag}> with style hash attribute" do
		example = Class.new(Phlex::HTML) do
			define_method :view_template do
				__send__(method_name, style: { color: "red", word_break: nil, font_weight: "bold" }) { "content" }
			end
		end

		expect(example.call) == %(<#{tag} style="color:red;font-weight:bold;">content</#{tag}>)
	end
end
