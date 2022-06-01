# frozen_string_literal: true

module Phlex
  module HTML
    TAGS.each do |tag|
      class_eval(<<-RUBY, __FILE__, __LINE__ + 1)
        def #{tag}(*args, **kwargs, &block)
          @children << Tag.new(self, :#{tag}, *args, **kwargs, &block)
        end
      RUBY
    end
  end
end
