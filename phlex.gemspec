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
	spec.required_ruby_version = ">= 2.7"

	spec.metadata["homepage_uri"] = spec.homepage
	spec.metadata["source_code_uri"] = "https://github.com/phlex-ruby/phlex"
	spec.metadata["changelog_uri"] = "https://github.com/phlex-ruby/phlex/blob/main/CHANGELOG.md"
	spec.metadata["funding_uri"] = "https://github.com/sponsors/joeldrapper"

	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files = Dir.chdir(File.expand_path(__dir__)) do
		`git ls-files -z`.split("\x0").reject do |f|
			(f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
		end
	end
	spec.require_paths = ["lib"]

	spec.add_dependency "concurrent-ruby", "~> 1.2"
	spec.add_dependency "zeitwerk", "~> 2.6"

	spec.metadata["rubygems_mfa_required"] = "true"
end
