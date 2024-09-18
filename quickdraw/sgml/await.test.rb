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

test "when given a non async task" do
	expect { Example.new("Hello").call }.to_raise(Phlex::ArgumentError) do |error|
		expect(error.message) == "Expected an asynchronous task / promise."
	end
end

test "async task flushes when waiting" do
	pid = Process.fork do
		require "async"

		Sync do
			task = Async { sleep 0.01; "Hello" }
			buffer = []
			Example.new(task).call(buffer)
			buffer => ["<h1>Before</h1>", "<h1>Hello</h1><h1>After</h1>"]
		end
	end

	pid, result = Process.wait2(pid)

	assert result.success?
end

test "async task doesn't flush when it doesn't need to wait" do
	pid = Process.fork do
		require "async"

		Sync do
			task = Async { sleep 0.01; "Hello" }
			task.wait
			buffer = []
			Example.new(task).call(buffer)
			buffer => ["<h1>Before</h1><h1>Hello</h1><h1>After</h1>"]
		end
	end

	pid, result = Process.wait2(pid)

	assert result.success?
end

test "concurrent promise flushes when waiting" do
	pid = Process.fork do
		require "concurrent"
		task = Concurrent::Promise.execute { sleep 0.01; "Hello" }
		buffer = []
		Example.new(task).call(buffer)
		buffer => ["<h1>Before</h1>", "<h1>Hello</h1><h1>After</h1>"]
	end

	pid, result = Process.wait2(pid)
	assert result.success?
end

test "concurrent promise doesn't flush when it doesn't need to wait" do
	pid = Process.fork do
		require "concurrent"
		task = Concurrent::Promise.execute { sleep 0.01; "Hello" }
		task.wait
		buffer = []
		Example.new(task).call(buffer)
		buffer => ["<h1>Before</h1><h1>Hello</h1><h1>After</h1>"]
	end

	pid, result = Process.wait2(pid)
	assert result.success?
end
