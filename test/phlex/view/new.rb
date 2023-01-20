# frozen_string_literal: true

class Example < Phlex::HTML
	def template(&block)
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

	def template
		h1 {
			yield
			text(", #{@name}")
		}
	end
end

describe Phlex::HTML do
	extend ViewHelper

	with "a block passed to new" do
		view do
			def template
				render Example.new { "Hello" }
			end
		end

		it "treats the block as content" do
			expect(output).to be == "<h1>Hello</h1>"
		end
	end

	with "a block and arguments passed to new" do
		view do
			def template
				render ExampleWithArgs.new("World", should_render: true) { "Hello" }
			end
		end

		it "treats the block as content, and passes the args on" do
			expect(output).to be == "<h1>Hello, World</h1>"
		end
	end
end
