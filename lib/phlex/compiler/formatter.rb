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
				text "" if @open_string_append

				super
			end

			def breakable(*args, **kwargs)
				if !@texting && @open_string_append
					@broken = kwargs
				else
					super
				end
			end

			def chain_append(&block)
				@appending = true

				if @open_string_append
					text '" << '
				elsif @open_chain_append
					text " << "
				else
					text "@_target << "
				end

				@open_string_append = false
				@open_chain_append = true

				yield(self)

				@appending = false
			end

			def append(&block)
				@appending = true

				unless @open_string_append
					if @open_chain_append
						text ' << "'
					else
						text '@_target << "'
					end

					@open_chain_append = false
					@open_string_append = true
				end

				yield(self)

				@appending = false
			end

			def text(value, ...)
				@texting = true

				unless @appending
					if @open_string_append
						super('"')
						@open_string_append = false
					end

					@open_chain_append = false

					breakable(**@broken) if @broken
				end

				@broken = false

				super

				@texting = false
			end
		end
	end
end
