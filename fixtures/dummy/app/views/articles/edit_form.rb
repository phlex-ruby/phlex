# frozen_string_literal: true

module Views
	module Articles
		class EditForm < ApplicationView
			include Phlex::Rails::Helpers::FormWith

			def template
				form_with url: "test", builder: MyFormBuilder do |f|
					f.my_text_field :name
				end
			end
		end
	end
end
