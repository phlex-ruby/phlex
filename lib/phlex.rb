# frozen_string_literal: true

require "active_support/core_ext/string/output_safety"

require_relative "phlex/version"
require_relative "phlex/callable"
require_relative "phlex/tag"
require_relative "phlex/tag/void_element"
require_relative "phlex/node"
require_relative "phlex/tag/standard_element"
require_relative "phlex/tags"
require_relative "phlex/context"
require_relative "phlex/component"
require_relative "phlex/text"

module Phlex
  class Error < StandardError; end
  # Your code goes here...
end
