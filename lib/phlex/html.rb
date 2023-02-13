# frozen_string_literal: true

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
	using Phlex::Overrides::Symbol::Name
end

module Phlex
	class HTML
		# A list of standard elements that have been registered.
		STANDARD_ELEMENTS = Concurrent::Map.new

		# A list of void elements that have been registered.
		VOID_ELEMENTS = Concurrent::Map.new

		# A list of HTML attributes that have the potential to execute unsafe JavaScript.
		EVENT_ATTRIBUTES = %w[onabort onafterprint onbeforeprint onbeforeunload onblur oncanplay oncanplaythrough onchange onclick oncontextmenu oncopy oncuechange oncut ondblclick ondrag ondragend ondragenter ondragleave ondragover ondragstart ondrop ondurationchange onemptied onended onerror onfocus onhashchange oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata onloadedmetadata onloadstart onmessage onmousedown onmousemove onmouseout onmouseover onmouseup onmousewheel onoffline ononline onpagehide onpageshow onpaste onpause onplay onplaying onpopstate onprogress onratechange onreset onresize onscroll onsearch onseeked onseeking onselect onstalled onstorage onsubmit onsuspend ontimeupdate ontoggle onunload onvolumechange onwaiting onwheel].to_h { [_1, true] }.freeze

		UNBUFFERED_MUTEX = Mutex.new

		extend Elements
		include Helpers, VoidElements, StandardElements

		class << self
			# Render the view to a String. Arguments are delegated to <code>new</code>.
			def call(...)
				new(...).call
			end

			alias_method :render, :call

			def new(*args, **kwargs, &block)
				if block
					object = super(*args, **kwargs, &nil)
					object.instance_variable_set(:@_content_block, block)
					object
				else
					super
				end
			end

			# @api private
			def rendered_at_least_once!
				alias_method :__attributes__, :__final_attributes__
				alias_method :call, :__final_call__
			end

			# @api private
			def __unbuffered_class__
				UNBUFFERED_MUTEX.synchronize do
					if defined? @unbuffered_class
						@unbuffered_class
					else
						@unbuffered_class = Class.new(Unbuffered)
					end
				end
			end
		end

		# Renders the view and returns the buffer. The default buffer is a mutable String.
		def call(buffer = +"", view_context: nil, parent: nil, &block)
			__final_call__(buffer, view_context: view_context, parent: parent, &block).tap do
				self.class.rendered_at_least_once!
			end
		end

		# @api private
		def __final_call__(buffer = +"", view_context: nil, parent: nil, &block)
			@_target = buffer
			@_view_context = view_context
			@_parent = parent

			block ||= @_content_block

			return buffer unless render?

			around_template do
				if block
					if DeferredRender === self
						__vanish__(self, &block)
						template
					else
						template do |*args|
							if args.length > 0
								yield_content_with_args(*args, &block)
							else
								yield_content(&block)
							end
						end
					end
				else
					template
				end
			end

			buffer
		end

		# Render another view
		# @param renderable [Phlex::HTML] the other view to render
		# @return [void]
		def render(renderable, &block)
			case renderable
			when Phlex::HTML
				renderable.call(@_target, view_context: @_view_context, parent: self, &block)
			when Class
				if renderable < Phlex::HTML
					renderable.new.call(@_target, view_context: @_view_context, parent: self, &block)
				end
			else
				raise ArgumentError, "You can't render a #{renderable}."
			end

			nil
		end

		# Output text content. The text will be HTML-escaped.
		def text(content)
			@_target << ERB::Util.html_escape(
				case content
					when String then content
					when Symbol then content.name
					when Integer then content.to_s
					else format_object(content) || content.to_s
				end
			)

			nil
		end

		# Output a whitespace character. This is useful for getting inline elements to wrap. If you pass a block, a whitespace will be output before and after yielding the block.
		def whitespace
			@_target << " "

			if block_given?
				yield
				@_target << " "
			end

			nil
		end

		# Output an HTML comment.
		def comment(&block)
			@_target << "<!-- "
			yield_content(&block)
			@_target << " -->"

			nil
		end

		# Output an HTML doctype.
		def doctype
			@_target << "<!DOCTYPE html>"
			nil
		end

		# This method is very dangerous and should usually be avoided. It will output the given String without any HTML safety. You should never use this method to output unsafe user input.
		# @param content [String|nil]
		# @return [nil]
		def unsafe_raw(content = nil)
			return nil unless content

			@_target << content
			nil
		end

		# Capture a block of output as a String.
		# @return [String]
		def capture(&block)
			return unless block_given?

			original_buffer = @_target
			new_buffer = +""

			begin
				@_target = new_buffer
				yield_content(&block)
			ensure
				@_target = original_buffer
			end

			new_buffer
		end

		# @api private
		def unbuffered
			self.class.__unbuffered_class__.new(self)
		end

		# Like `capture` but the output is vanished into a BlackHole buffer.
		# Because the BlackHole does nothing with the output, this should be faster.
		private def __vanish__(*args)
			return unless block_given?

			original_buffer = @_target

			begin
				@_target = BlackHole
				yield(*args)
			ensure
				@_target = original_buffer
			end

			nil
		end

		# Default render predicate can be overridden to prevent rendering
		private def render?
			true
		end

		private def format_object(object)
			case object
			when Float
				object.to_s
			end
		end

		# Override this method to hook in around a template render. You can do things before and after calling <code>super</code> to render the template. You should always call <code>super</code> so that callbacks can be added at different layers of the inheritance tree.
		private def around_template
			before_template
			yield
			after_template
		end

		# Override this method to hook in right before a template is rendered. Please remember to call <code>super</code> so that callbacks can be added at different layers of the inheritance tree.
		private def before_template
			nil
		end

		# Override this method to hook in right after a template is rendered. Please remember to call <code>super</code> so that callbacks can be added at different layers of the inheritance tree.
		private def after_template
			nil
		end

		# Yields the block and checks if it buffered anything. If nothing was buffered, the return value is treated as text.
		private def yield_content
			return unless block_given?

			original_length = @_target.length
			content = yield(self)
			unchanged = (original_length == @_target.length)

			if unchanged
				case content
				when String
					@_target << ERB::Util.html_escape(content)
				when Symbol
					@_target << ERB::Util.html_escape(content.name)
				when Integer
					@_target << ERB::Util.html_escape(content.to_s)
				else
					if (formatted_object = format_object(content))
						@_target << ERB::Util.html_escape(formatted_object)
					end
				end
			end

			nil
		end

		# Same as <code>yield_content</code> but accepts a splat of arguments to yield. This is slightly slower than <code>yield_content</code>, which is why it's defined as a different method because we don't always need arguments so we can usually use <code>yield_content</code> instead.
		private def yield_content_with_args(*args)
			return unless block_given?

			original_length = @_target.length
			content = yield(*args)
			unchanged = (original_length == @_target.length)

			if unchanged
				case content
				when String
					@_target << ERB::Util.html_escape(content)
				when Symbol
					@_target << ERB::Util.html_escape(content.name)
				when Integer, Float
					@_target << ERB::Util.html_escape(content.to_s)
				else
					if (formatted_object = format_object(content))
						@_target << ERB::Util.html_escape(formatted_object)
					end
				end
			end

			nil
		end

		# @api private
		private def __attributes__(**attributes)
			__final_attributes__(**attributes).tap do |buffer|
				Phlex::ATTRIBUTE_CACHE[attributes.hash] = buffer.freeze
			end
		end

		# @api private
		private def __final_attributes__(**attributes)
			if attributes[:href]&.start_with?(/\s*javascript:/)
				attributes.delete(:href)
			end

			if attributes["href"]&.start_with?(/\s*javascript:/)
				attributes.delete("href")
			end

			buffer = +""
			__build_attributes__(attributes, buffer: buffer)

			buffer
		end

		# @api private
		private def __build_attributes__(attributes, buffer:)
			attributes.each do |k, v|
				next unless v

				name = case k
					when String then k
					when Symbol then k.name.tr("_", "-")
					else k.to_s
				end

				# Detect unsafe attribute names. Attribute names are considered unsafe if they match an event attribute or include unsafe characters.
				if HTML::EVENT_ATTRIBUTES[name] || name.match?(/[<>&"']/)
					raise ArgumentError, "Unsafe attribute name detected: #{k}."
				end

				case v
				when true
					buffer << " " << name
				when String
					buffer << " " << name << '="' << ERB::Util.html_escape(v) << '"'
				when Symbol
					buffer << " " << name << '="' << ERB::Util.html_escape(v.name) << '"'
				when Hash
					__build_attributes__(
						v.transform_keys { |subkey|
							case subkey
								when Symbol then"#{k}-#{subkey.name.tr('_', '-')}"
								else "#{k}-#{subkey}"
							end
						}, buffer: buffer
					)
				else
					buffer << " " << name << '="' << ERB::Util.html_escape(v.to_s) << '"'
				end
			end

			buffer
		end

		# This should be the last method defined
		def self.method_added(method_name)
			if method_name[0] == "_" && Phlex::HTML.instance_methods.include?(method_name) && instance_method(method_name).owner != Phlex::HTML
				raise NameError, "👋 Redefining the method `#{name}##{method_name}` is not a good idea."
			end

			super
		end
	end
end
