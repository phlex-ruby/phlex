# frozen_string_literal: true

class HTMLExample < Phlex::HTML
end

describe Phlex::HTML do
	it "raises if you try to redefine an underscored method" do
		expect {
			HTMLExample.define_method(:_h1) { nil }
		}.to raise_exception(Phlex::NameError)
	end

	it "doesn't raise if you define a new underscored method" do
		HTMLExample.define_method(:_some_random_method) { nil }
	end
end

class SVGExample < Phlex::SVG
end

describe Phlex::SVG do
	it "raises if you try to redefine an underscored method" do
		expect { SVGExample.define_method(:_path) { nil } }.to raise_exception(Phlex::NameError)
	end

	it "doesn't raise if you define a new underscored method" do
		SVGExample.define_method(:_some_random_method) { nil }
	end
end
