class CancelSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(stripe_id, stripe_account_id)
    StripeSession.new.cancel_subscription(stripe_id, stripe_account_id)
  end
end
