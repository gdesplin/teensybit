FactoryBot.define do
  factory :form do
    daycare { nil }
    title { Faker::Lorem.unique.word }
    description { Faker::Lorem.words }
  end
end
