# frozen_string_literal: true

module Fixtures
	module Content
		class BareString < Phlex::HTML
			def template
				h1 { "Hello" }
			end
		end

		class Symbol < Phlex::HTML
			def template
				h1 { :hello }
			end
		end

		class Float < Phlex::HTML
			def template
				h1 { 1.2 }
			end
		end

		class Integer < Phlex::HTML
			def template
				h1 { 1 }
			end
		end

		class Variable < Phlex::HTML
			def template
				greeting = "Hello"
				h1 { greeting }
			end
		end

		class InstanceVariable < Phlex::HTML
			def template
				h1 { @hello }
			end
		end

		class NestedTags < Phlex::HTML
			def template
				article {
					h1 { "Inside" }
				}
			end
		end

		class NonMutatingNestedContent < Phlex::HTML
			def template
				div { say_hello }
			end

			def say_hello
				"Hello"
			end
		end
	end
end
