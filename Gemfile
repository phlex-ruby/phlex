# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem "rubocop"
gem "sus"
gem "benchmark-ips"
gem "yard"

group :test do
	gem "i18n"
	gem "memory_profiler"
end

group :development do
	gem "solargraph"
end
