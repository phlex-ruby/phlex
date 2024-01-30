# frozen_string_literal: true

class Example < Phlex::SVG
	def view_template
		svg do
			path(d: "123")
		end
	end
end

class ExampleFromHTML < Phlex::HTML
	def view_template
		svg do |s|
			s.path(d: "321")
		end
	end
end

describe Phlex::SVG do
	it "works" do
		expect(Example.call).to be == %(<svg><path d="123"></path></svg>)
	end

	it "works from html" do
		expect(ExampleFromHTML.call).to be == %(<svg><path d="321"></path></svg>)
	end
end
