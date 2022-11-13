# frozen_string_literal: true

module Fixtures
	module StandardElement
		class WithParens < Phlex::HTML
			def template
				h1()
			end
		end

		class WithoutParens < Phlex::HTML
			def template
				h1
			end
		end

		module WithAttributes
			class WithParens < Phlex::HTML
				def template
					h1(class: "font-bold")
				end
			end

			class WithoutParens < Phlex::HTML
				def template
					h1 class: "font-bold"
				end
			end
		end

		module WithBraceBlock
			class WithParens < Phlex::HTML
				def template
					h1() { "Hi" }
				end
			end

			class WithoutParens < Phlex::HTML
				def template
					h1 { "Hi" }
				end
			end

			class WithAttributes < Phlex::HTML
				def template
					h1(class: "font-bold") { "Hi" }
				end
			end
		end

		module WithDoBlock
			class WithParens < Phlex::HTML
				def template
					h1() do
						"Hi"
					end
				end
			end

			class WithoutParens < Phlex::HTML
				def template
					h1 do
						"Hi"
					end
				end
			end

			module WithAttributes
				class WithParens < Phlex::HTML
					def template
						h1(class: "font-bold") do
							"Hi"
						end
					end
				end

				class WithoutParens < Phlex::HTML
					def template
						h1 class: "font-bold" do
							"Hi"
						end
					end
				end
			end
		end
	end
end
