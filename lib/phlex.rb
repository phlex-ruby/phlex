# frozen_string_literal: true

require "cgi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Phlex
  extend self

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield configuration
  end
end
