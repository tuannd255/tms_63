User.create! name: "Pham Van Teo", email: "test@gmail.com",
  password: "1", password_confirmation: "1", role: 2

30.times do |n|
  name = Faker::Name.name
  email = "test#{n+1}@gmail.com"
  User.create!(name: name, email: email, password: "1",
     password_confirmation: "1", role: (n % 3))
end

30.times do |s|
  name = Faker::Name.name
  description = Faker::Lorem.sentence
  Subject.create! name: name, description: description,
  tasks_attributes: [
    {name:"Lesson 1", description: "lesson 1"},
    {name:"Lesson 2", description: "lesson 2"},
    {name:"Lesson 3", description: "lesson 3"},]
end
