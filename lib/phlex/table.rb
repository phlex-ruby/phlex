# frozen_string_literal: true

module Phlex
	module Table
		include Collection

		module ClassMethods
			def property(header_content, header: {}, cell: {}, &cell_content)
				if header_content.is_a?(String)
					header_content_text = header_content
					header_content = -> { text header_content_text }
				end

				properties << {
					header_content: header_content,
					header_attributes: header,
					cell_content: cell_content,
					cell_attributes: cell,
				}
			end

			def properties
				@properties ||= []
			end
		end

		def self.included(child)
			child.extend ClassMethods

			child.alias_method :table_template, :table
			child.alias_method :head_template, :thead
			child.alias_method :header_template, :th
			child.alias_method :body_template, :tbody
			child.alias_method :row_template, :tr
			child.alias_method :head_row_template, :row_template
			child.alias_method :cell_template, :td
		end

		def collection_template
			table_template do
				head_template do
					head_row_template do
						self.class.properties.each do |property|
							header_template(**property[:header_attributes], scope: "col") do
								instance_exec(&property[:header_content])
							end
						end
					end
				end

				body_template { yield_items }
			end
		end

		def item_template
			row_template do
				self.class.properties.each do |property|
					cell_template(**property[:cell_attributes]) do
						instance_exec(@item, &property[:cell_content])
					end
				end
			end
		end
	end
end
