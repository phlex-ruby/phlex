# frozen_string_literal: true

class Report < Phlex::CSV
	def view_template(user)
		column("id", user.id)
		column("name", user.name)
		column("email", user.email)
	end
end

User = Struct.new(:id, :name, :email)

it "works" do
	users = [
		User.new(
			id: 1,
			name: "John Doe",
			email: "john@gmail.com"
		),
		User.new(
			id: 2,
			name: "Jane Doe",
			email: "jane@example.com"
		)
	]

	puts Report.new(
		users
	).call
end
