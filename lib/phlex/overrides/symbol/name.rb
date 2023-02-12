# frozen_string_literal: true

module Phlex::Overrides::Symbol::Name
	refine(Symbol) { alias_method :name, :to_s }
end
