# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :test do
	gem "rubocop"
	gem "sus"
end

group :development do
	gem "solargraph"
	gem "yard"
	gem "benchmark-ips"
end
