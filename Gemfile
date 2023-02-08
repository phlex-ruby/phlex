# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem "rubocop"
gem "sus"
gem "zeitwerk"
gem "erb"

group :test do
	gem "i18n"
	gem "memory_profiler"
end


group :development do
	gem "benchmark-ips"
	gem "haml", "~> 6"	
	gem "slim", "~> 5"
	gem "hamlit", "~> 3"
end