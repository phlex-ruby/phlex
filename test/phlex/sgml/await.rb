# frozen_string_literal: true

class Example < Phlex::HTML
	def initialize(task)
		@task = task
	end

	def view_template
		h1 { "Before" }

		await(@task).then do |message|
			h1 { message }
		end

		h1 { "After" }
	end
end

describe Phlex::SGML do
	# The Async gem only works with CRuby 3.0 and above.
	if RUBY_ENGINE == "ruby" && RUBY_VERSION[0] > "3"
		describe "with Async tasks" do
			it "flushes when waiting" do
				Sync do
					task = Async { sleep 0.1; "Hello" }
					buffer = []
					Example.new(task).call(buffer)
					expect(buffer).to be == (["<h1>Before</h1>", "<h1>Hello</h1><h1>After</h1>"])
				end
			end

			it "doesn't flush when it doesn't need to wait" do
				Sync do
					task = Async { sleep 0.1; "Hello" }
					task.wait
					buffer = []
					Example.new(task).call(buffer)
					expect(buffer).to be == (["<h1>Before</h1><h1>Hello</h1><h1>After</h1>"])
				end
			end
		end
	end

	describe "with Concurrent Promise" do
		it "flushes when waiting" do
			task = Concurrent::Promise.execute { sleep 0.1; "Hello" }
			buffer = []
			Example.new(task).call(buffer)
			expect(buffer).to be == (["<h1>Before</h1>", "<h1>Hello</h1><h1>After</h1>"])
		end

		it "doesn't flush when it doesn't need to wait" do
			task = Concurrent::Promise.execute { sleep 0.1; "Hello" }
			task.wait
			buffer = []
			Example.new(task).call(buffer)
			expect(buffer).to be == (["<h1>Before</h1><h1>Hello</h1><h1>After</h1>"])
		end
	end
end
