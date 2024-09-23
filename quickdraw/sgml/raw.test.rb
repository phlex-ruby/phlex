# frozen_string_literal: true

require "sgml_helper"

include SGMLHelper

test "with an unsafe object" do
	expect { phlex { raw "<div></div>" } }.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "You passed an unsafe object to `raw`."
	end
end

test "with a safe object" do
	expect(phlex { raw safe %(<div class="hello">&</div>) }) == %(<div class="hello">&</div>)
end

test "with nil" do
	expect(phlex { div { raw nil } }) == %(<div></div>)
end

test "with empty string" do
	expect(phlex { div { raw "" } }) == %(<div></div>)
end
