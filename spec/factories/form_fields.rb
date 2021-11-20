FactoryBot.define do
  factory :form_field do
    form { nil }
    field_kind { "" }
    content { "MyString" }
    order { 1 }
  end
end
