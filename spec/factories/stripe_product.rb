FactoryBot.define do
  factory(:stripe_product) do
    active {nil}
    description {"ToFactory: RubyParser exception parsing this attribute"}
    name {"Daycare Service"}
    stripe_account_id {nil}
    stripe_id { Faker::Alphanumeric.unique.alpha(number: 10) }
  end
end
