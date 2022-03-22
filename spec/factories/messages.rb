FactoryBot.define do
  factory :message do
    message_body { "MyText" }
    user { nil }
    recipient_id { nil }
    chat_id { nil }
  end
end
