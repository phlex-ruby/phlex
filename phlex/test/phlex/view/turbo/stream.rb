# frozen_string_literal: true

describe Phlex::Turbo::Stream do
	extend ViewHelper

	with "with action and target" do
		view do
			def template
				render Phlex::Turbo::Stream.new(action: "replace", target: "users")
			end
		end

		it "produces the correct markup" do
			expect(output).to be ==
				"<turbo-stream action=\"replace\" target=\"users\"></turbo-stream>"
		end
	end

	with "custom action and additional attribute" do
		view do
			def template
				render Phlex::Turbo::Stream.new(action: "custom-action", message: "Hello world")
			end
		end

		it "produces the correct markup" do
			expect(output).to be ==
				"<turbo-stream action=\"custom-action\" message=\"Hello world\"></turbo-stream>"
		end
	end

	with "custom action, target and template content" do
		view do
			def template
				render Phlex::Turbo::Stream.new(action: "custom-action") do
					template_tag { "Hello World" }
				end
			end
		end

		it "produces the correct markup" do
			expect(output).to be ==
				"<turbo-stream action=\"custom-action\"><template>Hello World</template></turbo-stream>"
		end
	end
end
