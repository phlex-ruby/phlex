# frozen_string_literal: true

require "date"

class Example < Phlex::HTML
	def template
		h1 { Date.new(2022, 11, 28) }
	end

	private def format_object(object)
		case object
			when Date then object.strftime("%d/%m/%y")
			else super
		end
	end
end

describe Phlex::HTML do
	it "supports formatting objects" do
		expect(Example.new.call).to be == "<h1>28/11/22</h1>"
	end
end
