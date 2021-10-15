FactoryBot.define do
  factory(:stripe_billing_portal_configuration) do
    business_profile { {"headline" => nil, "privacy_policy_url" => "ToFactory: RubyParser exception parsing this attribute", "terms_of_service_url" => "ToFactory: RubyParser exception parsing this attribute"} }
    features { {"customer_update" => {"enabled" => false, "allowed_updates" => []}, "invoice_history" => {"enabled" => true}, "subscription_pause" => {"enabled" => false}, "subscription_cancel" => {"mode" => "at_period_end", "enabled" => false, "proration_behavior" => "none", "cancellation_reason" => {"enabled" => false, "options" => ["too_expensive", "missing_features", "switched_service", "unused", "other"]}}, "subscription_update" => {"enabled" => false, "proration_behavior" => "none", "default_allowed_updates" => []}, "payment_method_update" => {"enabled" => true}} }
    stripe_account_id {"acct_1JfnngDFrj4JR6YJ"}
    stripe_id {"bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9"}
  end
end
