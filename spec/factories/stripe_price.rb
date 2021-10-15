FactoryBot.define do
  factory(:stripe_price) do
    active {true}
    amount_cents {12000}
    amount_currency {"USD"}
    kind {nil}
    nickname {"ToFactory: RubyParser exception parsing this attribute"}
    recurring {{"interval" => "week", "interval_count" => 1} }
    stripe_id { Faker::Alphanumeric.unique.alpha(number: 10) }
    stripe_product_id {nil}
    user_id {nil}
  end
end
