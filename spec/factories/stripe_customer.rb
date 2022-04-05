FactoryBot.define do
  factory(:stripe_customer) do
    balance { 0 }
    delinquent {false}
    email {"justinanother19@gmail.com"}
    name {"Luke Skywalker"}
    phone {nil}
    stripe_id {"cus_KKCOj23DCctHK4"}
  end
end
