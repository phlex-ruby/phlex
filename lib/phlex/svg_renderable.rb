module Phlex
	# @abstract Subclass and define {#template} to create an HTML component class.
	module SvgRenderable
		include Renderable

		include Phlex::SVG::StandardElements

		def self.included(including_class)
			super

			including_class.extend(ClassMethods)

			# This should be extended after all method definitions
			including_class.extend(ElementClobberingGuard)
		end

		module ClassMethods
			include Phlex::Renderable::ClassMethods
		end
	end
end
