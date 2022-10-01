# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :rails do
	gem "rails"
end

group :test do
	gem "sus"
	gem "memory_profiler"
	gem "combustion"
end

group :docs do
	gem "rouge"
	gem "listen"
	gem "webrick"
	gem "zeitwerk"
	gem "redcarpet"
	gem "htmlbeautifier"
end

group :benchmark do
	gem "benchmark-ips"
end

gem "rubocop", require: false, github: "joeldrapper/rubocop", branch: "rubocop-user-agent"
gem "syntax_suggest"
