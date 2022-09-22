# frozen_string_literal: true

module ComponentHelper
	def self.extended(parent)
		parent.instance_exec do
			let(:output) { example.call }
			let(:example) { component.new }
		end
	end

	def component(&block)
		let :component do
			Class.new(Phlex::Component, &block)
		end
	end
end
