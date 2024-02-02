# frozen_string_literal: true

module ViewHelper
	def self.extended(parent)
		parent.include ViewHelper::Utils

		parent.class_exec do
			let(:output) { example.call }
			let(:example) { view.new }
		end
	end

	def view(&block)
		let :view do
			Class.new(Phlex::HTML, &block)
		end
	end

	def svg_view(&block)
		let :view do
			Class.new(Phlex::SVG, &block)
		end
	end

	module Utils
		def capture_stderr(&block)
			captured_stream = StringIO.new
			original_stream = $stderr
			$stderr = captured_stream

			block.call

			captured_stream.string.strip
		ensure
			$stderr = original_stream
		end
	end
end
