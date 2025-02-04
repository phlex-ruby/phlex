# frozen_string_literal: true

require "erb"
require "set"

module Phlex
	autoload :ArgumentError, "phlex/errors/argument_error"
	autoload :CSV, "phlex/csv"
	autoload :Context, "phlex/context"
	autoload :DoubleRenderError, "phlex/errors/double_render_error"
	autoload :Error, "phlex/error"
	autoload :FIFO, "phlex/fifo"
	autoload :FIFOCacheStore, "phlex/fifo_cache_store"
	autoload :HTML, "phlex/html"
	autoload :Helpers, "phlex/helpers"
	autoload :Kit, "phlex/kit"
	autoload :NameError, "phlex/errors/name_error"
	autoload :NullCacheStore, "phlex/null_cache_store"
	autoload :SGML, "phlex/sgml"
	autoload :SVG, "phlex/svg"
	autoload :Vanish, "phlex/vanish"

	Escape = ERB::Escape
	Null = Object.new.freeze

	DEPLOY_KEY = Process.clock_gettime(Process::CLOCK_MONOTONIC, :millisecond)
	CACHED_FILES = Set.new
	ATTRIBUTE_CACHE = FIFO.new

	def self.__expand_attribute_cache__(file_path)
		unless CACHED_FILES.include?(file_path)
			CACHED_FILES << file_path
			Phlex::ATTRIBUTE_CACHE.expand(File.size(file_path))
		end
	end
end

def 💪
	Phlex
end
