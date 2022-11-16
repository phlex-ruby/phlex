# frozen_string_literal: true

class MyFormBuilder < ActionView::Helpers::FormBuilder
	def my_label(attribute)
		label attribute, class: "label font-bold"
	end

	def my_text_field(attribute, **options)
		text_field attribute, class: "input input-bordered", **options
	end
end
