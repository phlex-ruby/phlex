# frozen_string_literal: true

module Views
	module Articles
		class CustomFormWith < ApplicationView
			include Phlex::Rails::Helpers::FormWith

			def template
				form_with url: "test", builder: MyFormBuilder do |f|
					f.my_label :name
					f.my_text_field :name
				end
			end
		end
	end
end
