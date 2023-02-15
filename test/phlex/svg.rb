# frozen_string_literal: true

class Example < Phlex::SVG
	def template
		svg do
			path(d: "123")
		end
	end
end

class ExampleFromHTML < Phlex::HTML
	def template
		svg do |s|
			s.path(d: "321")
		end
	end
end

describe Phlex::SVG do
	it "works" do
		expect(Example.call).to be == %(<svg><path d="123" /></svg>)
	end

	it "works from html" do
		expect(ExampleFromHTML.call).to be == %(<svg><path d="321" /></svg>)
	end
end
