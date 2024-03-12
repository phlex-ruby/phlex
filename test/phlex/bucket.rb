# frozen_string_literal: true

module Components
	extend Phlex::Bucket

	class SayHi < Phlex::HTML
		def initialize(name)
			@name = name
		end

		def template
			h1 { "Hi #{@name}" }
		end
	end
end

class Example < Phlex::HTML
	include Components

	def template
		SayHi("Joel")
	end
end

describe Phlex::Bucket do
	it "works" do
		expect(Example.new.call).to be == "<h1>Hi Joel</h1>"
	end
end
