# frozen_string_literal: true

module Phlex
	class Table < Phlex::Collection
		class << self
			def property(header, &block)
				if header.is_a?(String)
					header_text = header
					header = -> { text header_text }
				end

				properties << {
					header: header,
					body: block
				}
			end

			def properties
				@properties ||= []
			end
		end

		def collection_template
			table do
				thead do
					tr do
						self.class.properties.each do |property|
							th scope: "col" do
								instance_exec(&property[:header])
							end
						end
					end
				end

				tbody { yield_items }
			end
		end

		def item_template
			tr do
				self.class.properties.each do |property|
					td do
						instance_exec(@item, &property[:body])
					end
				end
			end
		end
	end
end
