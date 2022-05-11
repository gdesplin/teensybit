FactoryBot.define do
  factory :form_field do
    description { "MyString" }
    form { nil }
    field_kind { "string" }
    position { 1 }
    question { Faker::Lorem.unique.words }
    required { false }
  end
end
