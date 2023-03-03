# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	Phlex::HTML::StandardElements.send(:slow_registered_elements).each do |method_name|
		# template_tag is a special case because the method_name != the tag name
		next if method_name == :template_tag

		with "<#{method_name}> called with an underscore prefix while overridden" do
			view do
				define_method :template do
					send("_#{method_name}")
				end

				define_method method_name do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{method_name}></#{method_name}>)
			end
		end

		with "<#{method_name}> with block content and attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{method_name} class="class" id="id" disabled><h1>Hello</h1></#{method_name}>)
			end
		end

		with "<#{method_name}> with block text content and attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false) { "content" }
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{method_name} class="class" id="id" disabled>content</#{method_name}>)
			end
		end
	end

	with "<template> called with an underscore prefix while overridden" do
		view do
			define_method :template do
				send("_template_tag")
			end

			define_method :template_tag do
				super(class: "overridden")
			end
		end

		it "is not overridden" do
			expect(output).to be == %(<template></template>)
		end
	end

	with "<template> with block content and attributes" do
		view do
			define_method :template do
				template_tag(class: "class", id: "id", disabled: true, selected: false) { h1 { "Hello" } }
			end
		end

		it "produces the correct output" do
			expect(output).to be == %(<template class="class" id="id" disabled><h1>Hello</h1></template>)
		end
	end

	with "<template> with block text content and attributes" do
		view do
			define_method :template do
				template_tag(class: "class", id: "id", disabled: true, selected: false) { "content" }
			end
		end

		it "produces the correct output" do
			expect(output).to be == %(<template class="class" id="id" disabled>content</template>)
		end
	end

	Phlex::HTML::VoidElements.send(:slow_registered_elements).each do |method_name|
		with "<#{method_name}> called with an underscore prefix while overridden" do
			view do
				define_method :template do
					send("_#{method_name}")
				end

				define_method method_name do
					super(class: "overridden")
				end
			end

			it "is not overridden" do
				expect(output).to be == %(<#{method_name}>)
			end
		end

		with "<#{method_name}> with attributes" do
			view do
				define_method :template do
					send(method_name, class: "class", id: "id", disabled: true, selected: false)
				end
			end

			it "produces the correct output" do
				expect(output).to be == %(<#{method_name} class="class" id="id" disabled>)
			end
		end
	end
end
