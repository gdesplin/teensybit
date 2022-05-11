FactoryBot.define do
  factory :child_event do
    child { nil }
    user { nil }
    happened_at { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    description { "MyText" }
  end
end
