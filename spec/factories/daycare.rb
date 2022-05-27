FactoryBot.define do
  factory :daycare do
    address { Faker::Address.street_address }
    address_two { Faker::Address.secondary_address }
    city { Faker::Address.city }
    name { Faker::Company.name }
    phone { Faker::PhoneNumber.cell_phone }
    state { Faker::Address.state_abbr }
    user_id { nil }
    zip { Faker::Address.zip }
    slug { nil }
  end
end
