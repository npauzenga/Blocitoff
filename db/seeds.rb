# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Generate users

10.times do
  password = Faker::Lorem.characters(10)
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    email_confirmed: true
  )
end
users = User.all

admin = User.create(
  name: "Admin",
  email: "admin@admin.com",
  password: "helloworld",
  password_confirmation: "helloworld",
  email_confirmed: true
)

nate = User.create(
  name: "Nate",
  email: "plabass@gmail.com",
  password: "helloworld",
  password_confirmation: "helloworld",
  email_confirmed: true
)

50.times do
  Todo.create!(
    description: Faker::Hipster.sentence,
    user: users.sample
  )
end
