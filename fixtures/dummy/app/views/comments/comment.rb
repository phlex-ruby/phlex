# frozen_string_literal: true

module Views
	module Comments
		class Comment < Phlex::Component
			def template
				render(::Comment.new(name: "_why", body: "I'm back"))
			end
		end
	end
end
