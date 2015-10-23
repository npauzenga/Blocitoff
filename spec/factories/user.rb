FactoryGirl.define do
  factory :user do
    name "Abraham Lincoln"
    sequence(:email, 100) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    email_confirmed true
    confirm_token nil
  end

  factory :unconfirmed_user do
    name "Thomas Jefferson"
    sequence(:email, 500) { |n| "user#{n}@example.com" }
    password "helloworld"
    password_confirmation "helloworld"
    email_confirmed false
    confirm_token nil
  end
end
