require "singleton"

module Phlex
  class ComponentRegistry
    include Singleton

    def initialize
      @components = {}
      @cache = {}
    end

    def register(component)
      parts = component.name.split("::")
      path_pairs = parts.size.times.map { |n| [parts[0, n], parts[n, parts.size]] }

      path_pairs.each do |(parent, child)|
        parent = parent.join("::")
        child = child.join("_").to_sym
        @components[parent] ||= {}
        @components[parent][child] = component
      end
    end

    def fetch(component_name, context)
      cached_fetch = @cache[[component_name, context]]
      return cached_fetch if cached_fetch.present?

      parts = context.name.split("::")
      component = parts.size
                       .times
                       .lazy
                       .map { |n| parts.first(parts.size - n) }
                       .map { |path_parts| path_parts.join("::") }
                       .map { |path| @components.dig(path, component_name) }
                       .find(&:itself)

      component ||= @components[""][component_name]
      cache_fetch(component_name, context, component)
      component
    end

    def cache_fetch(component_name, context, component)
      @cache[[component_name, context]] = component
    end
  end
end
