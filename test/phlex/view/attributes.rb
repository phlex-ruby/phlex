# frozen_string_literal: true

require "test_helper"

describe Phlex::View do
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

	with '@class name' do
		view do
			def template
				div class: 'header'
			end

			def class_attribute(value)
				"#{value}123abc"
			end
		end

		it "compiles the class name" do
			expect(output).to be == %(<div class="header123abc"></div>)
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
