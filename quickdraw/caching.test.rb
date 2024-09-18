# frozen_string_literal: true

test "using a component without a source location" do
	expect {
		# Intentionally not passing a source location here.
		eval <<~RUBY
			class Example < Phlex::HTML
				def view_template
				end
			end
		RUBY
	}.not_to_raise
end
