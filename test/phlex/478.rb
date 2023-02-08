# frozen_string_literal: true

class Things < Phlex::HTML
	def template(&things)
		div(&things)
	end

	def thing
		render(Thing)
	end
end

class Thing < Phlex::HTML
	def template
		div { "Dang!" }
	end
end

class A < Phlex::HTML
	def template
		render(Things.new, &:thing)
	end
end

class B < Phlex::HTML
	def template
		render Things.new do |things|
			things.thing
		end
	end
end

describe Phlex::HTML do
	it "supports procs from Symbols" do
		a, b = A.call, B.call

		expect(a).to be == "<div><div>Dang!</div></div>"
		expect(b).to be == "<div><div>Dang!</div></div>"
	end
end
