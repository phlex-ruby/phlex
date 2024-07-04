# frozen_string_literal: true

describe Phlex::SGML do
	extend ViewHelper

	with "non lowercase id" do
		view do
			def view_template
				div(iD: "a")
			end
		end

		it "raises" do
			expect { output }.to raise_exception(Phlex::ArgumentError)
		end
	end

	with "non symbolic id" do
		view do
			def view_template
				div("id" => "a")
			end
		end

		it "raises" do
			expect { output }.to raise_exception(Phlex::ArgumentError)
		end
	end
end
