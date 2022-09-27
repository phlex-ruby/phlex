# frozen_string_literal: true

module Views
	module Articles
		class Form < Phlex::View
			def template
				form_with url: "test" do |f|
					f.text_field :name
				end
			end
		end
	end
end
