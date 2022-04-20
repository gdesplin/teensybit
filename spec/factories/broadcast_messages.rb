FactoryBot.define do
  factory :broadcast_message do
    message_body { Faker::Lorem.words }
    users { nil }
    sender { nil }
  end
end
