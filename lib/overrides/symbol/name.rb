module Overrides::Symbol::Name
  refine(Symbol) { alias_method :name, :to_s }
end
