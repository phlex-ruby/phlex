# frozen_string_literal: true

require_relative "lib/phlex/version"

Gem::Specification.new do |spec|
  spec.name = "phlex"
  spec.version = Phlex::VERSION
  spec.authors = ["Joel Drapper"]
  spec.email = ["joel@drapper.me"]

  spec.summary = "Flexible components"
  spec.description = "Better view components"
  spec.homepage = "https://github.com/joeldrapper/phlex"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/joeldrapper/phlex"
  spec.metadata["changelog_uri"] = "https://github.com/joeldrapper/phlex"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_dependency "zeitwerk", "~> 2.6"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
