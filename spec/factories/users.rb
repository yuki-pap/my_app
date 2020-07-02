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

FactoryBot.define do
  factory :login_user,class: User do
    name { "Example" }
    email { "test@example.com" }
    password {"foobar"}
    password_confirmation {"foobar"}
    activated true
    activated_at Time.zone.now

    factory :login_user_with_studies do

      transient do
        studies_count { 1 }
      end

      after(:create) do |user, evaluator|
        create_list(:study_today, evaluator.studies_count,user: user)
        create_list(:study_yesterday, evaluator.studies_count, user: user)
        create_list(:month,evaluator.studies_count {1},user: user)
      end
    end
  end
  factory :study do

    count {5}
    user

    trait :today do
      created_at Time.current
      date Time.current.strftime("%Y年%m月%d日")
    end

    trait :yesterday do
      created_at Time.current.yesterday
      date Time.current.yesterday.strftime("%Y年%m月%d日")
    end

    factory :study_today, traits: [:today]
    factory :study_yesterday, traits: [:yesterday]
  end
  factory :month do
    month Time.current.strftime("%Y年%m月")
    time_count {10}
    user
  end
end
