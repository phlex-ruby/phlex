# frozen_string_literal: true

require "isolated_test_helper"

describe Phlex::View do
	extend ViewHelper

	with "naughty text" do
		view do
			def template
				text %("><script type="text/javascript" src="bad_script.js"></script>)
			end
		end

		it "escapes the content" do
			expect(output).to be == "&quot;&gt;&lt;script type=&quot;text/javascript&quot; src=&quot;bad_script.js&quot;&gt;&lt;/script&gt;"
		end
	end

	with "naughty tag attribute values" do
		view do
			def template
				article id: %("><script type="text/javascript" src="bad_script.js"></script>)
			end
		end

		it "escapes the attributes" do
			expect(output).to be == %(<article id="&quot;&gt;&lt;script type=&quot;text/javascript&quot; src=&quot;bad_script.js&quot;&gt;&lt;/script&gt;"></article>)
		end
	end

	with "naughty javascript link protocol in href" do
		view do
			def template
				a "naughty link", href: "javascript:javascript:alert(1)"
			end
		end

		it "strips the javascript protocol" do
			expect(output).to be == %{<a href="alert(1)">naughty link</a>}
		end
	end

	Phlex::HTML::EVENT_ATTRIBUTES.each_key do |event_attribute|
		with "with naughty #{event_attribute} attribute" do
			naughty_attributes = { event_attribute => "alert(1);" }

			view do
				define_method :template do
					send(:div, **naughty_attributes)
				end
			end

			it "raises an ArgumentError" do
				expect { output }.to raise_exception ArgumentError,
					message: "Unsafe attribute name detected: #{event_attribute}."
			end
		end
	end

	%w[< > & " '].each do |naughty_character|
		with "naughty attribute name containing #{naughty_character}" do
			naughty_attribute = "abc#{naughty_character}123"
			naughty_attributes = { naughty_attribute => "alert(1);" }

			view do
				define_method :template do
					send(:div, **naughty_attributes)
				end
			end

			it "raises an ArgumentError" do
				expect { output }.to raise_exception ArgumentError,
					message: "Unsafe attribute name detected: #{naughty_attribute}."
			end
		end
	end
end
