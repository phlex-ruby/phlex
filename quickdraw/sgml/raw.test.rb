# frozen_string_literal: true

def render(&)
	Phlex::HTML.new.call do |e|
		e.instance_exec(&)
	end
end

test "with an unsafe object" do
	expect {
		render do
			raw "<div></div>"
		end
	}.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "You passed an unsafe object to `raw`."
	end
end

test "with a safe object" do
	expect(
		render do
			raw safe %(<div class="hello">&</div>)
		end,
	) == %(<div class="hello">&</div>)
end

test "with nil" do
	expect(
		render do
			div do
				raw nil
			end
		end,
	) == %(<div></div>)
end

test "with empty string" do
	expect(
		render do
			div do
				raw ""
			end
		end,
	) == %(<div></div>)
end
