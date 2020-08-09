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
        create_list(:marker_red, evaluator.studies_count, user: user)
        create_list(:marker_yellow, evaluator.studies_count, user: user)
        create_list(:marker_blue, evaluator.studies_count, user: user)
        create_list(:marker_green, evaluator.studies_count, user: user)
        create_list(:marker_yellowgreen, evaluator.studies_count, user: user)
        create_list(:marker_lightblue, evaluator.studies_count, user: user)
        create_list(:time_by_field, evaluator.studies_count, user: user)
      end
    end
  end
  factory :study do

    count {5}
    user

    trait :today do
      created_at Time.current
      date Time.current.strftime("%Y年%m月%d日")

      transient do
        studies_count { 1 }
      end
      after(:create) do |study, evaluator|
        create_list(:task, evaluator.studies_count,study: study)
      end
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

  factory :task do
    content {"タスク"}
    study
  end

  factory :marker do
    field 'test'

    trait :red do
      color {'Red'}
      number {1}
    end

    trait :yellow do
      color {'Yellow'}
      number {2}
    end

    trait :blue do
      color {'Blue'}
      number {3}
    end

    trait :lightblue do
      color {'Light-Blue'}
      number {4}
    end

    trait :yellowgreen do
      color {'Yellow-Green'}
      number {5}
    end

    trait :green do
      color {'Green'}
      number {6}
    end

    factory :marker_red, traits: [:red]
    factory :marker_yellow, traits: [:yellow]
    factory :marker_blue, traits: [:blue]
    factory :marker_green, traits: [:green]
    factory :marker_yellowgreen, traits: [:yellowgreen]
    factory :marker_lightblue, traits: [:lightblue]



  end



  factory :time_by_field do
    user
    color {'red'}
    count {5}
    field {'ruby'}
    transient do
      studies_count { 1 }
    end
    after(:create) do |time_by_field, evaluator|
      create_list(:time_by_field_today, evaluator.studies_count,time_by_field: time_by_field)
    end
  end

  factory :time_by_field_today do
    time_by_field
    count {5}
  end



end
