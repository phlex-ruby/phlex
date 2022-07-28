# frozen_string_literal: true

require "cgi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Phlex
  NAMESPACE_DELINEATOR = "::"
  extend self

  def find_constant(name, relative_to:)
    try_to_find_constant(name, relative_to:) || relative_to.const_get(name, _inherit = false)
    # relative_to.class_eval(name)
  end

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield configuration
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

  # Given:
  #
  #  module A
  #    module B; end
  #  end
  #
  # Then:
  #
  #  > namespace_above('A::B')
  #  => A
  #  > namespace_above('A::B::Foo')
  #  => A::B
  #  > namespace_above('A::B::Foo::Bar')
  #  => A::B
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
