FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2020-09-07 13:18:39" }
  end
end
