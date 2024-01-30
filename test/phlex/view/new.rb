# frozen_string_literal: true

class Example < Phlex::HTML
	def view_template(&block)
		h1(&block)
	end
end

class ExampleWithArgs < Phlex::HTML
	def initialize(name, should_render: false)
		@name = name
		@should_render = should_render
	end

	def render?
		@should_render
	end

	def view_template
		h1 {
			yield
			plain(", #{@name}")
		}
	end
end

describe Phlex::HTML do
	extend ViewHelper

	with "a block passed to new" do
		view do
			def view_template
				render Example.new { "Hello" }
			end
		end

		it "treats the block as content" do
			expect(output).to be == "<h1>Hello</h1>"
		end
	end

	with "a block and arguments passed to new" do
		view do
			def view_template
				render ExampleWithArgs.new("World", should_render: true) { "Hello" }
			end
		end

		it "treats the block as content, and passes the args on" do
			expect(output).to be == "<h1>Hello, World</h1>"
		end
	end
end
