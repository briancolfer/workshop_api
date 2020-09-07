FactoryBot.define do
  factory :person do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birth_date { Faker::Date.birthday(min_age:  18, max_age: 65)}
  end
end
