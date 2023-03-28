# frozen_string_literal: true

class LabelComponent < Phlex::HTML
	def template(&block)
		label(class: "text-md font-normal", &block)
	end
end

describe Phlex::HTML do
	extend ViewHelper

	with "hooks" do
		view do
			extend Phlex::ComponentRegistrar

			register_components label_component: LabelComponent

			def template
				label_component { "Password" }
			end
		end

		it "allows component registration" do
			expect(output).to be == '<label class="text-md font-normal">Password</label>'
		end
	end
end
