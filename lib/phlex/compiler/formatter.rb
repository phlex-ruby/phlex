# frozen_string_literal: true

module Phlex
	class Compiler
		class Formatter < SyntaxTree::Formatter
			def genspace
				-> (n) { "\t" * (n / 2) }
			end

			def format(node, stackable: true)
				stack << node if stackable
				doc = node.format(self)
				stack.pop if stackable
				doc
			end

			def flush
				text "" if @open_append

				super
			end

			def breakable(*args, **kwargs)
				if !@texting && @open_append
					@broken = kwargs
				else
					super
				end
			end

			def append(&block)
				@appending = true

				unless @open_append
					text %(@_target << ")
					@open_append = true
				end

				yield(self)

				@appending = false
			end

			def text(value, ...)
				@texting = true

				unless @appending
					if @open_append
						super('"')
						@open_append = false
					end

					breakable(**@broken) if @broken
				end

				@broken = false

				super

				@texting = false
			end
		end
	end
end
