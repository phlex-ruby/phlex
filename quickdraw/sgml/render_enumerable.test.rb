# frozen_string_literal: true

class Card < Phlex::HTML
	def view_template(&block)
		article(&block)
	end
end

class WithoutBlock < Phlex::HTML
	def initialize
		@cards = [
			Card.new,
			Card.new
		]
	end

	def view_template
		render @cards
	end
end

class WithBlock < WithoutBlock
	def view_template
		render @cards do
			h1 { "Hi" }
		end
	end
end

describe Phlex::SGML do
	test "can render enumerables without a block" do
		expect(WithoutBlock.call) == "<article></article><article></article>"
	end

	test "can render enumerables with a block" do
		expect(WithBlock.call) == "<article><h1>Hi</h1></article><article><h1>Hi</h1></article>"
	end
end
