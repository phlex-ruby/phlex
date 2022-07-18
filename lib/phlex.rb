# frozen_string_literal: true

require "active_support/core_ext/string/output_safety"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Phlex
  extend self

  def find_constant(name, relative_to:)
    try_to_find_constant(name, relative_to:) || relative_to.const_get(name, _inherit = false)
    # relative_to.class_eval(name)
  end

  private

  def try_to_find_constant(name, relative_to: Module)
    if relative_to.const_defined?(name, _inherit = false)
      relative_to.const_get(name, _inherit = false)
    elsif (parent = namespace_above(relative_to.name))
      try_to_find_constant(name, relative_to: parent)
    elsif const_defined?("::#{name}", _inherit = false)
      const_get("::#{name}", _inherit = false)
    end
  end

  def namespace_above(name)
    path = name.split("::")[..-2].join("::")
    return if path.empty?

    if const_defined?("::#{path}", _inherit = false)
      const_get("::#{path}", _inherit = false)
    else
      namespace_above(path)
    end
  end
end
