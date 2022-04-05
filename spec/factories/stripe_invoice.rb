FactoryBot.define do
  factory(:stripe_invoice) do
    collection_method { "charge_automatically"}
    hosted_invoice_url {"https://invoice.stripe.com/i/acct_1JfXobD9xYX6CfpF/test_YWNjdF8xSmZYb2JEOXhZWDZDZnBGLF9LS0NPOUZOME16RFYzZ0FDdzFMOXcxeTE2Q1ZnMk5V0100rdl3Ca0d"}
    invoice_pdf {"https://pay.stripe.com/invoice/acct_1JfXobD9xYX6CfpF/test_YWNjdF8xSmZYb2JEOXhZWDZDZnBGLF9LS0NPOUZOME16RFYzZ0FDdzFMOXcxeTE2Q1ZnMk5V0100rdl3Ca0d/pdf"}
    paid {true}
    stripe_customer_id {nil}
    stripe_id { Faker::Alphanumeric.unique.alpha(number: 10) }
    stripe_subscription_id {nil}
    total_cents {99900}
    total_currency {"USD"}
  end
end
