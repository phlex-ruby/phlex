# frozen_string_literal: true

require "cgi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

if Gem::Version.new(RUBY_VERSION) < Gem::Version.new("3.0")
  unless Symbol.instance_methods.include?(:name)
    class Symbol
      def name
        to_s.freeze
      end
    end
  end
end

module Phlex
  Error = Module.new
  ArgumentError = Class.new(ArgumentError) { include Error }

  extend self

  ATTRIBUTE_CACHE = {}

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield configuration
  end
end
