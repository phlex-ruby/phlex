# frozen_string_literal: true

module Pages
	class Index < ApplicationPage
		def template
			render Layout.new(title: "Introduction to Phlex") do
				render Markdown.new(<<~MD)
	 				# Introduction

					Phlex is a framework for building fast, reusable, testable views in pure Ruby.

					Each view object is an instance of a specific class of view. The nav-bar, for example, might contain three different nav-bar-items, but they’re all instances of the nav-bar-item class. This class, then, manifests everything there is to know about nav bar items in general. It models:

					1. the **data** attributes being represented — perhaps url and label;
					2. a **template**, which dictates how the data should be represented with HTML markup and CSS classes; and
					3. **logic**, conditions, or calculations on the data — perhaps a predicate method to determine whether the link is active or not.

					# Why use Phlex?

					## Better developer experience 🎉

					You don’t need to introduce a new language like Slim, HAML, or ERB. Phlex views are plain old Ruby objects: view classes are just Ruby classes, templates are just methods, and HTML tags are just method calls. If you know how to define a method that calls another method, you pretty much already know how to use Phlex.

					## Better safety 🥽
					Rails partials can implicitly depend on instance variables from a controller or view. This happens more often than you might think when copying code into a new partial extraction. If the partial is then rendered in a different context or the instance variable’s meaning changes, things can break quite severely without warning.

					Conversely, Phlex view templates render in an isolated execution context where only the instance variables and methods for the specific view are exposed.

					## Better performance 🚀

					Phlex is ~4.35× faster than ActionView and ~2× faster than ViewComponent. Phlex views are also streamable.

					Rails apps typically spend 40-80% of the response time rendering views, so this could be a significant factor in overall app performance.
				MD
			end
		end
	end
end
