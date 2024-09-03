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

# The Async gem only works with CRuby 3.0 and above.
if RUBY_ENGINE == "ruby" && RUBY_VERSION[0] > "3"
	test "async task flushes when waiting" do
		Sync do
			task = Async { sleep 0.01; "Hello" }
			buffer = []
			Example.new(task).call(buffer)
			expect(buffer) == (["<h1>Before</h1>", "<h1>Hello</h1><h1>After</h1>"])
		end
	end

	test "async task doesn't flush when it doesn't need to wait" do
		Sync do
			task = Async { sleep 0.01; "Hello" }
			task.wait
			buffer = []
			Example.new(task).call(buffer)
			expect(buffer) == (["<h1>Before</h1><h1>Hello</h1><h1>After</h1>"])
		end
	end
end

test "concurrent promise flushes when waiting" do
	task = Concurrent::Promise.execute { sleep 0.01; "Hello" }
	buffer = []
	Example.new(task).call(buffer)
	expect(buffer) == (["<h1>Before</h1>", "<h1>Hello</h1><h1>After</h1>"])
end

test "concurrent promise doesn't flush when it doesn't need to wait" do
	task = Concurrent::Promise.execute { sleep 0.01; "Hello" }
	task.wait
	buffer = []
	Example.new(task).call(buffer)
	expect(buffer) == (["<h1>Before</h1><h1>Hello</h1><h1>After</h1>"])
end
