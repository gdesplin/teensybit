class DeactivateStripePriceJob < ApplicationJob
  queue_as :default

  def perform(stripe_id, stripe_account_id)
    StripeSession.new.set_price_to_inactive(stripe_id, stripe_account_id)
  end
end
