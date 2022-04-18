FactoryBot.define do
  factory :message do
    message_body { "MyText" }
    user { nil }
    recipient_id { 1 }
    chat_id { nil }
  end
end
