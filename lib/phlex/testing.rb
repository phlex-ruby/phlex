# frozen_string_literal: true

require "phlex"

module Phlex::Testing
	autoload :SGML, "phlex/testing/sgml"
	autoload :Capybara, "phlex/testing/capybara"
	autoload :Nokogiri, "phlex/testing/nokogiri"
	autoload :Nokolexbor, "phlex/testing/nokolexbor"
end
