FactoryBot.define do
  factory :user do
    address {nil}
    address_two {nil}
    admin {nil}
    city {nil}
    confirmation_sent_at {"2021-09-08T03:23 UTC"}
    confirmation_token { Faker::Alphanumeric.unique.alpha(number: 10) }
    confirmed_at {"2021-09-08T03:24 UTC"}
    current_sign_in_at {"2021-10-13T17:08 UTC"}
    current_sign_in_ip{ "" }
    daycare_id {nil}
    email { Faker::Internet.unique.email }
    password {"Password123"}
    failed_attempts {0}
    invitation_accepted_at {nil}
    invitation_created_at {nil}
    invitation_limit {nil}
    invitation_sent_at {nil}
    invitation_token {nil}
    invitations_count {0}
    invited_by_id {nil}
    invited_by_type {nil}
    kind {"provider"}
    last_sign_in_at {"2021-09-14T03:20 UTC"}
    last_sign_in_ip { Faker::Internet.public_ip_v4_address }
    locked_at {nil}
    name { Faker::Name.name }
    phone {nil}
    remember_created_at {nil}
    reset_password_sent_at {nil}
    reset_password_token {nil}
    sign_in_count {5}
    state {nil}
    stripe_customer_id {nil}
    unconfirmed_email {nil}
    unlock_token {nil}
    zip {nil}
  end
end
