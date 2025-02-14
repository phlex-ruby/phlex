# frozen_string_literal: true

require "erb"
require "set"

module Phlex
	autoload :Kit, "phlex/kit"
	autoload :FIFO, "phlex/fifo"
	autoload :Vanish, "phlex/vanish"
	autoload :Helpers, "phlex/helpers"
	autoload :FIFOCacheStore, "phlex/fifo_cache_store"

	autoload :CSV, "phlex/csv"
	autoload :SVG, "phlex/svg"
	autoload :HTML, "phlex/html"
	autoload :SGML, "phlex/sgml"

	autoload :Error, "phlex/error"
	autoload :NameError, "phlex/errors/name_error"
	autoload :RuntimeError, "phlex/errors/runtime_error"
	autoload :ArgumentError, "phlex/errors/argument_error"
	autoload :DoubleRenderError, "phlex/errors/double_render_error"

	Escape = ERB::Escape

	DEPLOYED_AT = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
	CACHED_FILES = Set.new
	ATTRIBUTE_CACHE = FIFO.new

	def self.__expand_attribute_cache__(file_path)
		unless CACHED_FILES.include?(file_path)
			CACHED_FILES << file_path
			Phlex::ATTRIBUTE_CACHE.expand(File.size(file_path))
		end
	end

	def self.eager_load
		queue = [self]

		while (mod = queue.shift)
			mod.constants.each do |const_name|
				const = mod.const_get(const_name)
				queue << const if Module === const
			end
		end
	end

	# Generate an HTML string using Phlex’ HTML DSL
	def self.html(&block)
		HTML.call do |component|
			receiver = block.binding.receiver

			receiver.instance_variables.each do |ivar|
				next if component.instance_variable_defined?(ivar)

				value = receiver.instance_variable_get(ivar)
				component.instance_variable_set(ivar, value)
			end

			component.instance_exec(receiver, &block)
		end
	end

	# Generate an SVG string using Phlex’ SVG DSL
	def self.svg(&block)
		SVG.call do |component|
			receiver = block.binding.receiver

			receiver.instance_variables.each do |ivar|
				next if component.instance_variable_defined?(ivar)

				value = receiver.instance_variable_get(ivar)
				component.instance_variable_set(ivar, value)
			end

			component.instance_exec(receiver, &block)
		end
	end
end

def 💪
	Phlex
end
