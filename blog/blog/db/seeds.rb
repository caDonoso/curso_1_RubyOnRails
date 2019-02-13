# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do
	Category.create(
		[{
			name: Faker::Color.color_name
		}]
	)
end

	
User.create([{
	email: "cristobalantonio.donoso@gmail.com",
	password: "asd123",
	password_confirmation: "asd123",
	permission_level: 3
}])


5.times do
	User.create(
		[{
			email: Faker::Internet.email,
			password: "asd123",
			password_confirmation: "asd123"
		}]
			
	)
end

20.times do
	Mountain.create(
		[{
			name: "Cerro#{Faker::FunnyName.name}",
			description: Faker::Lorem.paragraph,
			altitude: Faker::Number.between(500, 6000),
			user_id: Faker::Number.between(1, 5),
			categories: ["1", "2", "3"]
		}]
	)
end