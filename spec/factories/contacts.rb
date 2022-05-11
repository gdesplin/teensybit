FactoryBot.define do
  factory :contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    notes { Faker::Lorem.words }
    message { Faker::Lorem.words }
    opt_in_emails { Faker::Lorem.words }
    source { "get_started" }
  end
end
