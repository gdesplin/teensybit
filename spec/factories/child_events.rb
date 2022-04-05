FactoryBot.define do
  factory :child_event do
    child { nil }
    user { nil }
    happened_at { "2022-03-03 10:11:13" }
    description { "MyText" }
  end
end
