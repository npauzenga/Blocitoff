FactoryGirl.define do
  factory :user do
    name "Abraham Lincoln"
    sequence(:email, 100) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
  end
end
