# frozen_string_literal: true

test "inline html with no yield" do
	output = Phlex.html do
		h1 { "Hi" }
	end

	assert_equal_html output, <<~HTML.strip
		<h1>Hi</h1>
	HTML
end

class Foo
	def self.woo = "woo"
end

def tag
	"tag"
end

test "inline html with a yield param" do
	@foo = "Hi"

	output = Phlex.html do |tag|
		# self here is Phlex but pretending to be the outer self
		h1 { @foo }
		h1 { tag.h2 { "#{h2}#{self.tag}" } }
	end

	assert_equal_html output, <<~HTML.strip
		<h1>Hi</h1><h1><h2>2tag</h2></h1>
	HTML
end

def foo = 1
def h2 = 2
