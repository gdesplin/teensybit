FactoryBot.define do
  factory :form_field do
    form { nil }
    field_kind { "" }
    content { "MyString" }
    position { 1 }
  end
end
