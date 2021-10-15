FactoryBot.define do
  factory(:stripe_account) do
    charges_enabled {false}
    country {"US"}
    daycare_id {nil}
    details_submitted {true}
    stripe_id { Faker::Alphanumeric.unique.alpha(number: 10) }
  end
end
