# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :test do
	gem "sus"
	gem "quickdraw", github: "joeldrapper/quickdraw", ref: "061b0fa9c6f10bc95190de2e1f2812fa52ff01a3"
	gem "simplecov", require: false
	if RUBY_ENGINE == "ruby" && RUBY_VERSION[0] > "3"
		gem "async"
	end
	gem "concurrent-ruby"
	gem "selenium-webdriver"
end

group :development do
	gem "rubocop"
	gem "solargraph"
	gem "yard"
	gem "benchmark-ips"
end
