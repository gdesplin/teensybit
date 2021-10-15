FactoryBot.define do
  factory(:stripe_payment_intent) do
    amount_received_cents {99900}
    amount_received_currency {"USD"}
    stripe_customer_id {nil}
    stripe_id { Faker::Alphanumeric.unique.alpha(number: 10) }
    stripe_invoice_id {nil}
  end
end
