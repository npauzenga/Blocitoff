FactoryGirl.define do
  factory :confirmed_user, class: User do
    name "Abraham Lincoln"
    sequence(:email, 100) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    email_confirmed true
    after(:create) { |user| user.confirm_token = nil }
    after(:create) { |user| user.confirm_digest = nil }
    after(:create) { |user| EncryptPassword.call(user: user) }
  end

  factory :unconfirmed_user, class: User do
    name "Abraham Lincoln"
    sequence(:email, 200) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    email_confirmed false

    after(:create) do |user|
      user.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
    after(:create) do |user|
      user.confirm_digest = Encryptor.digest_token(user.confirm_token)
    end
    after(:create) do |user|
      EncryptPassword.call(user: user)
    end
  end
end
