# frozen_string_literal: true

describe Phlex::HTML do
	extend ViewHelper

	with "hash attributes" do
		view do
			def template
				div data: { name: { first_name: "Joel" } }
			end
		end

		it "flattens the attributes" do
			expect(output).to be == %(<div data-name-first-name="Joel"></div>)
		end
	end

	with "string keyed hash attributes" do
		view do
			def template
				div data: { "name_first_name" => "Joel" }
			end
		end

		it "flattens the attributes without dasherizing them" do
			expect(output).to be == %(<div data-name_first_name="Joel"></div>)
		end
	end

	with "an array of string attributes" do
		view do
			def template
				div(class: %w(bg-red-500 rounded))
			end
		end

		it "joins the array with a space" do
			expect(output).to be == %(<div class="bg-red-500 rounded"></div>)
		end
	end

	with "an array of symbol attributes" do
		view do
			def template
				div(class: %i(bg-red-500 rounded))
			end
		end

		it "joins the array with a space" do
			expect(output).to be == %(<div class="bg-red-500 rounded"></div>)
		end
	end

	with "an array of symbol and string attributes" do
		view do
			def template
				div(class: ["bg-red-500", :rounded])
			end
		end

		it "joins the array with a space" do
			expect(output).to be == %(<div class="bg-red-500 rounded"></div>)
		end
	end

	with "an object that is not a boolean, String, Symbol, Array, or Hash" do
		view do
			def template
				div(class: Object.new)
			end
		end

		it "raises a Phlex::ArgumentError" do
			expect { output }.to raise_exception(Phlex::ArgumentError)
		end
	end

	with "an array that has an object that is not a boolean, String, Symbol, Array, or Hash" do
		view do
			def template
				div(class: ["bg-red-500", :rounded, Object.new])
			end
		end

		it "raises a Phlex::ArgumentError" do
			expect { output }.to raise_exception(Phlex::ArgumentError)
		end
	end

	if RUBY_ENGINE == "ruby"
		with "unique tag attributes" do
			view do
				def template
					div class: SecureRandom.hex
				end
			end

			let :report do
				view.new.call

				MemoryProfiler.report do
					2.times { view.new.call }
				end
			end

			it "doesn't leak memory" do
				expect(report.total_retained).to be == 0
			end
		end
	end
end
