# frozen_string_literal: true

require "phlex"
require "phlex/rails/engine"

module Phlex::Rails
	Loader = Zeitwerk::Loader.for_gem(warn_on_extra_files: false).tap do |loader|
		loader.push_dir("#{__dir__}/rails", namespace: Phlex::Rails)
		loader.setup
	end
end
