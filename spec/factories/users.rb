FactoryBot.define do
  factory :user do
    name "Example"
    sequence(:email){ |n| "test#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    activated true
    activated_at Time.zone.now 
  end
end
