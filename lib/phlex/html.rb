# frozen_string_literal: true

class Phlex::HTML < Phlex::SGML
	autoload :StandardElements, "phlex/html/standard_elements"
	autoload :VoidElements, "phlex/html/void_elements"

	extend Phlex::SGML::Elements
	include VoidElements, StandardElements

	# Output an HTML doctype.
	def doctype
		context = @_context

		context.buffer << "<!doctype html>"
		nil
	end

	# Outputs an `<svg>` tag
	# @return [nil]
	# @see https://developer.mozilla.org/docs/Web/SVG/Element/svg
	def svg(...)
		if block_given?
			super do
				render Phlex::SVG.new do |svg|
					yield(svg)
				end
			end
		else
			super
		end
	end

	def filename
		nil
	end

	def content_type
		"text/html"
	end
end
