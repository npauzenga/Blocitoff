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

password = "helloworld"
password_salt = Encryptor.generate_salt

User.create(
  name: "Admin",
  email: "admin@admin.com",
  password: password,
  password_confirmation: password,
  password_salt: password_salt,
  password_hash: Encryptor.digest_password(password, password_salt),
  email_confirmed: true
)

users = User.all

50.times do
  Todo.create!(
    description: Faker::Hipster.sentence,
    user: users.sample
  )
end
