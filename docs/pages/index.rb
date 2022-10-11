# frozen_string_literal: true

module Pages
	class Index < ApplicationPage
		def template
			render Layout.new(title: "Introduction to Phlex, a fast, object-oriented view framework for Ruby") do
				render Markdown.new(<<~MD)
	 				# Introduction

					Phlex is a framework for building fast, reusable, testable views in pure Ruby.

					## Better developer experience 💃

					Phlex views are plain old Ruby objects. View classes are just Ruby classes, templates are just methods, and HTML tags are just method calls. If you know how to define a method that calls another method, you pretty much already know how to use Phlex.

					## Better safety 🥽

					Phlex view templates render in an isolated execution context where only the instance variables and methods for the specific view are exposed.

					## Better performance 🔥

					Rendering a Phlex view is ~4.35× faster than an ActionView partial and ~2× faster than ViewComponent component.
				MD
			end
		end
	end
end
