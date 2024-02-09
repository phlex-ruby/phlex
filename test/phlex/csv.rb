class Report < Phlex::CSV
	def template(user)
		user => { id:, name:, email: }

		column("id", id)
		column("name", name)
		column("email", email)
	end
end

User = Data.define(:id, :name, :email)

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
