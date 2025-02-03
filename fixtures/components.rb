# frozen_string_literal: true

module Components
	extend Phlex::Kit

	autoload :SayHi, "components/say_hi"
	autoload :Article, "components/article"

	module Foo
		class Bar < Phlex::HTML
			def view_template
				h1 { "Bar" }
			end
		end
	end
end
