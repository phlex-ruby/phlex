# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

group :test do
	gem "sus"
	gem "quickdraw", github: "joeldrapper/quickdraw"
	gem "simplecov", require: false
	gem "async" if RUBY_ENGINE == "ruby"
	gem "concurrent-ruby"
	gem "selenium-webdriver"
end

group :development do
	gem "rubocop"
	gem "solargraph"
	gem "yard"
	gem "benchmark-ips"
end
