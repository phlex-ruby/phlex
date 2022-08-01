require "phlex"
require "phlex/rails"
require "rails/all"
require "rspec-html-matchers"

RSpec.configure do |config|
  config.include RSpecHtmlMatchers
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.example_status_persistence_file_path = "spec/examples.txt"

  config.disable_monkey_patching!

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 1

  config.order = :random

  Kernel.srand config.seed
end
