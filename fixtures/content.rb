# frozen_string_literal: true

module Fixtures
	module Content
		class BareString < Phlex::View
			def template
				h1 { "Hello" }
			end
		end

		class Symbol < Phlex::View
			def template
				h1 { :hello }
			end
		end

		class Float < Phlex::View
			def template
				h1 { 1.2 }
			end
		end

		class Integer < Phlex::View
			def template
				h1 { 1 }
			end
		end

		class Variable < Phlex::View
			def template
				greeting = "Hello"
				h1 { greeting }
			end
		end

		class InstanceVariable < Phlex::View
			def template
				h1 { @hello }
			end
		end

		class NestedTags < Phlex::View
			def template
				article {
					h1 { "Inside" }
				}
			end
		end

		class NonMutatingNestedContent < Phlex::View
			def template
				div { say_hello }
			end

			def say_hello
				"Hello"
			end
		end
	end
end
