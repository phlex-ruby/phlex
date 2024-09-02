# frozen_string_literal: true

# TODO: We should remove this eventually
test "target is an alias for the buffer" do
	context = Phlex::Context.new
	expect(context.target).to_be_a(String)
end
