FactoryBot.define do
  factory :workshop do
    workshop_name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_date { Faker::Date.in_date_period(month: 7)}
    end_date {start_date + 2.days }

    trait :start_date_after_end_date do
      end_date { start_date - 2.days }
    end

  end

  factory :invalid_workshop do
    workshop_name { "" }
    description { Faker::Lorem.paragraph}
  end
end
