# frozen_string_literal: true

require_relative "lib/phlex/version"

Gem::Specification.new do |spec|
	spec.name = "phlex"
	spec.version = Phlex::VERSION
	spec.authors = ["Joel Drapper"]
	spec.email = ["joel@drapper.me"]

	spec.summary = "A fun framework for building views in Ruby."
	spec.description = "A high-performance view framework optimised for fun."
	spec.homepage = "https://www.phlex.fun"
	spec.license = "MIT"
	spec.required_ruby_version = ">= 3.3.1"

	spec.metadata["homepage_uri"] = spec.homepage
	spec.metadata["source_code_uri"] = "https://github.com/phlex-ruby/phlex"
	spec.metadata["changelog_uri"] = "https://github.com/phlex-ruby/phlex/blob/main/CHANGELOG.md"
	spec.metadata["funding_uri"] = "https://github.com/sponsors/joeldrapper"

	spec.files = Dir[
		"README.md",
		"LICENSE.txt",
		"lib/**/*.rb"
	]

	spec.require_paths = ["lib"]

	spec.metadata["rubygems_mfa_required"] = "true"
end
