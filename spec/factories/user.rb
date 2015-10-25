FactoryGirl.define do
  factory :user do
    name "Abraham Lincoln"
    sequence(:email, 100) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    email_confirmed true
    after(:create) { |user| user.confirm_token = nil }
  end

  factory :unconfirmed_user, class: User do
    name "Abraham Lincoln"
    sequence(:email, 200) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    email_confirmed false
  end
end
