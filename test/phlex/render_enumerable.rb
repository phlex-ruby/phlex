# frozen_string_literal: true

class Card < Phlex::HTML
	def template(&block)
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

	def template
		render @cards
	end
end

class WithBlock < WithoutBlock
	def template
		render @cards do
			h1 { "Hi" }
		end
	end
end

describe Phlex::HTML do
	it "can render enumerables without a block" do
		expect(WithoutBlock.call).to be == "<article></article><article></article>"
	end

	it "can render enumerables with a block" do
		expect(WithBlock.call).to be == "<article><h1>Hi</h1></article><article><h1>Hi</h1></article>"
	end
end
