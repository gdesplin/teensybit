FactoryBot.define do
  factory :entered_form_field do
    entered_form { nil }
    entered_string { "MyString" }
    entered_text { "MyText" }
    entered_datetime { "2021-11-02 10:29:53" }
    entered_date { "2021-11-02" }
    entered_time { "2021-11-02 10:29:53" }
  end
end
