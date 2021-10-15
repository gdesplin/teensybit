FactoryBot.define do
  factory(:daycare) do
    address {"ToFactory: RubyParser exception parsing this attribute"}
    address_two {""}
    city {"Washington"}
    name {"Red Rock Daycare"}
    phone {"4353130549"}
    state {"UT"}
    user_id {nil}
    zip {"84780"}
  end
end
