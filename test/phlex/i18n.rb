# frozen_string_literal: true

require "test_helper"

describe Phlex::I18n do
	extend ViewHelper

	view do
		include Phlex::I18n

		def template
			text translate("hello")
		end
	end

	it "supports I18n translations" do
		expect(I18n).to receive(:translate).with("hello").and_return "hola"
		expect(output).to be == "hola"
	end
end
