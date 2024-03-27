# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :test do
	gem "sus"
	if RUBY_ENGINE == "ruby" && RUBY_VERSION[0] > "3"
		gem "async"
	end
	gem "concurrent-ruby"
end

group :development do
	gem "rubocop"
	gem "solargraph"
	gem "yard"
	gem "benchmark-ips"
end
