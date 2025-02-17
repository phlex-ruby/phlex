# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.2"

gemspec

group :test do
	gem "sus"
	gem "quickdraw", github: "joeldrapper/quickdraw"
	gem "simplecov", require: false
	gem "selenium-webdriver"
end

group :development do
	gem "rubocop"
	gem "ruby-lsp"
	gem "benchmark-ips"
end
