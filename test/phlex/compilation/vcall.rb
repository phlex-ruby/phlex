# frozen_string_literal: true

require "test_helper"
require "compilation/vcall"

describe Phlex::Compiler do
	with "a standard element" do
		let(:compiler) {
			Phlex::Compiler.new(
				Fixtures::Compilation::VCall::WithStandardElement
			)
		}

		it "compiles the method" do
			expect(compiler).to receive(:redefine).with_arguments <<~RUBY.chomp
				def template
					@_target << "<div></div>"
				end
			RUBY

			compiler.call
		end
	end

	with "a void element" do
		let(:compiler) {
			Phlex::Compiler.new(
				Fixtures::Compilation::VCall::WithVoidElement
			)
		}

		it "compiles the method" do
			expect(compiler).to receive(:redefine).with_arguments <<~RUBY.chomp
				def template
					@_target << "<img />"
				end
			RUBY

			compiler.call
		end
	end

	with "another method call" do
		let(:compiler) {
			Phlex::Compiler.new(
				Fixtures::Compilation::VCall::WithAnotherMethodCall
			)
		}

		it "retains the original method call" do
			expect(compiler).to receive(:redefine).with_arguments <<~RUBY.chomp
				def template
					@_target << "<article></article>"
					some_other_method
					@_target << "<article></article>"
				end
			RUBY

			compiler.call
		end
	end

	with "a redefined tag method" do
		let(:compiler) { Phlex::Compiler.new(Fixtures::Compilation::VCall::WithRedefinedTagMethod) }
		let(:optimized_methods) { [] }

		it "doesn't optimize overridden HTML tag methods" do
			mock(compiler) do |mock|
				mock.before(:redefine) { optimized_methods << _1 }
			end

			compiler.call

			expect(optimized_methods).to be == [
				<<~RUBY.chomp,
					def template
						title
						@_target << "<article></article>"
					end
				RUBY

				<<~RUBY.chomp
					def title
						@_target << "<h1></h1>"
					end
				RUBY
			]
		end
	end
end
