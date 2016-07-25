User.create! name: "Pham Van Teo", email: "test@gmail.com",
  password: "1", password_confirmation: "1", role: 2

20.times do |n|
  name = Faker::Name.name
  email = "test#{n+1}@gmail.com"
  User.create!(name: name, email: email, password: "1",
     password_confirmation: "1", role: (n % 3))
end

20.times do |n|
  name = Faker::Name.title
  description = Faker::Name.name
  Subject.create!(name: name, description: description)
end
