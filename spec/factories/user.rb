FactoryGirl.define do
  factory :user do
    email "johndoe@example.com"
    first_name "John"
    last_name  "Doe"
    phone_number 5551234567
    password   "password"
    password_confirmation "password"
    after(:create) { |user| user.api_keys.first.update_attributes(access_token: "token") }
  end
end
