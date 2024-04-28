# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "a return value" do
		view do
			attr_accessor :captured

			def view_template
				h1 { "Before" }
				@captured = capture { "Hello" }
				h1 { "After" }
			end
		end

		it "captures the return value" do
			expect(example.call).to be == "<h1>Before</h1><h1>After</h1>"
			expect(example.captured).to be == "Hello"
		end
	end

	with "a block" do
		view do
			attr_accessor :captured

			def view_template
				h1 { "Before" }
				@captured = capture do
					h1 { "Hello" }
				end
				h1 { "After" }
			end
		end

		it "captures the return value" do
			expect(example.call).to be == "<h1>Before</h1><h1>After</h1>"
			expect(example.captured).to be == "<h1>Hello</h1>"
		end
	end

	with "a call to flush inside the block" do
		view do
			attr_accessor :captured

			def view_template
				h1 { "Before" }
				@captured = capture do
					h1 { "Hello" }
					flush
					h1 { "World" }
				end
				h1 { "After" }
			end
		end

		it "should still contain the full capture" do
			expect(example.call).to be == "<h1>Before</h1><h1>After</h1>"
			expect(example.captured).to be == "<h1>Hello</h1><h1>World</h1>"
		end
	end

	with "a call to flush inside a component rendered in the block" do
		let(:component) do
			Class.new(Phlex::HTML) do
				def view_template
					h1 { "Hello" }
					flush
					h1 { "World" }
				end
			end
		end

		let(:previewer) do
			Class.new(Phlex::HTML) do
				def view_template
					srcdoc = capture { yield } if block_given?

					iframe srcdoc:
				end
			end
		end

		view do
			def view_template
				h1 { "Before" }
				render @_view_context.previewer do
					render @_view_context.component
				end
				h1 { "After" }
			end
		end

		it "should contain the full capture" do
			expect(example.call(view_context: self)).to be == %(<h1>Before</h1><iframe srcdoc="<h1>Hello</h1><h1>World</h1>"></iframe><h1>After</h1>)
		end

		it "should contain the full capture if the buffer is provided" do
			my_buffer = +""
			example.call(my_buffer, view_context: self)
			expect(my_buffer).to be == %(<h1>Before</h1><iframe srcdoc="<h1>Hello</h1><h1>World</h1>"></iframe><h1>After</h1>)
		end
	end
end
