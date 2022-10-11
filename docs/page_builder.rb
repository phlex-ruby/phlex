# frozen_string_literal: true

class PageBuilder
	ROOT = Pages::ApplicationPage

	def self.build_all
		FileUtils.mkdir_p("#{__dir__}/dist")
		FileUtils.cp_r("#{__dir__}/assets", "#{__dir__}/dist")
		ROOT.subclasses.each { |page| new(page).call }
	end

	def initialize(page)
		@page = page
	end

	def call
		puts "Building #{@page.name}"
		FileUtils.mkdir_p(directory)
		File.write(file, @page.new.call)
	end

	private

	def file
		"#{directory}/index.html"
	end

	def directory
		if path == "index"
			"#{__dir__}/dist"
		else
			"#{__dir__}/dist/#{path}"
		end
	end

	def path
		@page.name.split("::")[1..].map { _1.gsub(/(.)([A-Z])/, '\1-\2') }.map(&:downcase).join("/")
	end
end
