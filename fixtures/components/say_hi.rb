# frozen_string_literal: true

class Components::SayHi < Phlex::HTML
	def initialize(name, times: 1)
		@name = name
		@times = times
	end

	def view_template
		article {
			@times.times { h1 { "Hi #{@name}" } }
			yield
		}
	end
end
