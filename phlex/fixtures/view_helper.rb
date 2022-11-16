# frozen_string_literal: true

module ViewHelper
	def self.extended(parent)
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
end
