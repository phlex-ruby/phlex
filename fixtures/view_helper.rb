# frozen_string_literal: true

module ViewHelper
	def self.extended(parent)
		parent.class_exec do
			let(:output) { example.call }
			let(:example) { view.new }
		end
	end

	def view(&)
		let :view do
			Class.new(Phlex::View, &)
		end
	end
end
