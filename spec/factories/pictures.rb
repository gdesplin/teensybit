FactoryBot.define do
  factory :picture do
    daycare { nil }
    title { "MyString" }
    description { "MyString" }
    user { nil }
    public_to_daycare { false }
  end
end
