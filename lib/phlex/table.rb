# frozen_string_literal: true

module Phlex
	module Table
		include Collection

		module ClassMethods
			attr_accessor :header

			def property(header = nil, **attributes, &body)
				if header.is_a?(String)
					header_text = header
					header = -> { head_header(scope: "col") { header_text } }
				end

				properties << {
					header:,
					body:,
					attributes:,
				}
			end

			def properties
				@properties ||= []
			end
		end

		def self.included(child)
			child.extend ClassMethods

			child.alias_method :head, :thead
			child.alias_method :body, :tbody
			child.alias_method :foot, :tfoot

			child.alias_method :row, :tr

			child.alias_method :header, :th
			child.alias_method :cell, :td

			child.alias_method :head_row, :row
			child.alias_method :body_row, :row
			child.alias_method :foot_row, :row

			child.alias_method :head_header, :header
			child.alias_method :foot_header, :header

			child.alias_method :head_cell, :cell
			child.alias_method :body_cell, :cell
			child.alias_method :foot_cell, :cell
		end

		private

		def properties
			self.class.properties
		end

		def collection_template(&)
			table do
				head_template
				body_template(&)
				foot_template
			end
		end

		def item_template
			row_template
		end

		def head_template
			if self.class.properties.any? { |p| p[:header] }
				head do
					head_row do
						self.class.properties.each do |property|
							case property[:header]
							when Proc
								instance_exec(&property[:header])
							when Symbol
								send(property[:header])
							end
						end
					end
				end
			end
		end

		def body_template
			body { yield_items }
		end

		def foot_template
		end

		def row_template
			body_row do
				self.class.properties.each do |property|
					body_cell(**property[:attributes]) do
						instance_exec(@item, &property[:body])
					end
				end
			end
		end
	end
end
