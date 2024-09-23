# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "text comment" do
	expect(
		phlex {
			comment { "Hello World" }
		},
	) == %(<!-- Hello World -->)
end

test "block comment with markup" do
	expect(
		phlex {
			comment {
				h1 { "Hello World" }
			}
		},
	) == %(<!-- <h1>Hello World</h1> -->)
end
