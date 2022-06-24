# frozen_string_literal: true
require "digest"

module Phlex
  class Component
    include Node, Context

    SUBCOMPONENT_REGEX = /component\s([A-Z]+[A-Za-z:]*)/

    module ClassMethods
      include Cacheable

      def cache_key
        @cache_key ||= CacheKey.new(
          super,
          subcomponents,
          cacheable_ancestors
        )
      end

      def cache_version
        @cache_version ||= CacheVersion.new(
          super,
          subcomponents,
          cacheable_ancestors
        )
      end

      def subcomponents
        @subcomponents ||= direct_subcomponents.reduce(Set.new) do |set, component|
          set << component
          component.subcomponents.each { set << _1 }
          set
        end
      end

      private

      def cacheable_ancestors
        @cacheable_ancestors ||= ancestors.lazy
          .reject { [self, Object, BasicObject, Kernel].include? _1 }
          .reject { _1.name.start_with? "Phlex::" }
          .map { CacheableObject.new(_1) }.to_a
      end

      def direct_subcomponents
        source_file.scan(SUBCOMPONENT_REGEX).flatten.map do
          Phlex.find_constant(_1, relative_to: self)
        end
      end
    end

    extend ClassMethods

    module Overrides
      def initialize(*args, parent: nil, cache: false, assigns: [], **kwargs, &block)
        @_parent = parent
        @_cache = cache
        @_content = block

        super(*args, **kwargs)

        copy_assigns
      end

      def call
        return super unless @_cache
        Rails.cache.fetch(self) { super }
      end
    end

    def self.inherited(child)
      child.prepend(Overrides)
      super
    end

    def initialize(**attributes)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def call
      template(&@_content)
      super
    end

    def render_context
      @_render_context ||= self
    end

    def <<(node)
      render_context.children << node
    end

    def render(*args, **kwargs, &block)
      return instance_exec(*args, **kwargs, &block) if block_given?

      content = args[0]

      case content
      when String
        instance_exec { text content }
      when Proc
        instance_exec(&content)
      else
        raise ArgumentError
      end
    end

    def render_tag(tag, &block)
      old_render_context = render_context.dup
      @_render_context = tag
      instance_eval(&block)
      @_render_context = old_render_context
    end

    def assigns
      instance_variables
        .reject { _1.start_with? "@_" }
        .map { [_1, instance_variable_get(_1)] }.to_h
    end

    def copy_assigns
      return unless @_parent

      @_parent.assigns.each do |k, v|
        instance_variable_set(k, v) unless instance_variables.include?(k)
      end
    end

    def method_missing(...)
      super unless @_parent
      @_parent.send(...)
    end

    def respond_to_missing?(name)
      super unless @_parent
      @_parent.respond_to?(name)
    end

    def cache_key
      @cache_key ||= CacheKey.new(
        self.class,
        cacheable_content,
        cacheable_resources
      )
    end

    def cache_version
      @cache_version ||= CacheVersion.new(
        RUBY_VERSION,
        Phlex::VERSION,
        self.class,
        cacheable_content,
        cacheable_resources
      )
    end

    def cacheable_resources
      (@_cache == true) ? assigns : @_cache
    end

    def cacheable_content
      CacheableObject.new(@_content)
    end
  end
end
