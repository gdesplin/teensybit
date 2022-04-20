FactoryBot.define do
  factory(:stripe_customer) do
    balance { 0 }
    delinquent { false }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    phone { nil }
    stripe_id { "cus_KKCOj23DCctHK4" }
  end
end
