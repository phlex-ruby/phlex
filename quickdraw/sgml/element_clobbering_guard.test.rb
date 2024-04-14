# frozen_string_literal: true

class Example < Phlex::HTML
end

test "raises if you try to redefine an underscored method" do
	expect { Example.define_method(:_h1) { nil } }.to_raise(Phlex::NameError)
end

test "doesn't raise if you define a new underscored method" do
	expect {
		Example.define_method(:_some_random_method) { nil }
	}.not_to_raise
end
