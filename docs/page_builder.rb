# frozen_string_literal: true

class PageBuilder
	ROOT = Pages::ApplicationPage

	def self.build_all
		ROOT.subclasses.each { |page| new(page).call }
	end

	def initialize(page)
		@page = page
	end

	def call
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
		@page.name.downcase.split("::")[1..].join("/")
	end
end
