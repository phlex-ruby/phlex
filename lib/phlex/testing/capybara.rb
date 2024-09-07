# frozen_string_literal: true

require "capybara"

module Phlex::Testing::Capybara
	include Phlex::Testing::SGML

	def self.included(mod)
		if defined?(Minitest::Test) && Minitest::Test > mod
			require "capybara/minitest"
			mod.include Capybara::Minitest::Assertions
		end

		if defined?(RSpec::Core::ExampleGroup) && RSpec::Core::ExampleGroup > mod
			require "capybara/rspec"
			mod.include Capybara::RSpecMatchers
		end
	end

	attr_reader :page
	alias_method :component, :page

	def render(...)
		@page = ::Capybara::Node::Simple.new(
			render_to_string(...),
		)
	end
end
