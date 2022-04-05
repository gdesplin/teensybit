FactoryBot.define do
  factory(:stripe_subscription) do
    cancel_at_period_end {false}
    canceled_at {nil}
    current_period_end {nil}
    current_period_start {nil}
    ended_at {nil}
    next_pending_invoice_item_invoice {nil}
    pending_invoice_item_interval {nil}
    status {"trialing"}
    stripe_customer_id {nil}
    stripe_id { Faker::Alphanumeric.unique.alpha(number: 10) }
    stripe_price_id  {nil}
    trial_end {nil}
    trial_start {nil}
  end
end
