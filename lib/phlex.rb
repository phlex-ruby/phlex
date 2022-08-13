# frozen_string_literal: true

require "cgi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/generators")
loader.setup

module Phlex
  extend self

  ATTRIBUTE_CACHE = {}

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield configuration
  end
end
