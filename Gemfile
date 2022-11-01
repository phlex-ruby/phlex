# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem "benchmark-ips"
gem "benchmark-memory"
gem "capybara"
gem "rails"
gem "rubocop"
gem "solargraph"
gem "sus"
gem "syntax_suggest"
gem "zeitwerk"

group :test do
	gem "i18n"
	gem "memory_profiler"
	gem "covered"
end

group :rails do
	gem "combustion"
end

group :docs do
	gem "filewatcher"
	gem "htmlbeautifier"
	gem "redcarpet"
	gem "webrick"
	gem "rouge"
end
