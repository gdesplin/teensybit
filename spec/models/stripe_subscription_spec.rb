require 'rails_helper'

RSpec.describe StripeSubscription, type: :model do
  it { is_expected.to respond_to(:cancel_at_period_end) }
  it { is_expected.to respond_to(:canceled_at) }
  it { is_expected.to respond_to(:current_period_end) }
  it { is_expected.to respond_to(:current_period_start) }
  it { is_expected.to respond_to(:ended_at) }
  it { is_expected.to respond_to(:next_pending_invoice_item_invoice) }
  it { is_expected.to respond_to(:pending_invoice_item_interval) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to respond_to(:stripe_customer_id) }
  it { is_expected.to respond_to(:stripe_id) }
  it { is_expected.to respond_to(:stripe_price_id) }
  it { is_expected.to respond_to(:trial_end) }
  it { is_expected.to respond_to(:trial_start) }

  describe "#is_valid?" do
    subject { stripe_subscription.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:owner) { create(:user) }
    let(:user) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }
    let(:stripe_customer) { create(:stripe_customer) }
    let(:stripe_price) { create(:stripe_price, stripe_product: stripe_product, user: user) }
    let(:stripe_product) { create(:stripe_product, stripe_account: stripe_account) }
    let(:stripe_subscription) { build(:stripe_subscription, stripe_id: stripe_id, stripe_price: stripe_price, stripe_customer: stripe_customer) }

    context "When stripe_customer is not present" do
      let(:stripe_customer) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_price is not present" do
      let(:stripe_price) { nil }

      it { is_expected.to be true }
    end

    context "When stripe_id is not present" do
      let(:stripe_id) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_subscription, stripe_id: stripe_id, stripe_customer: stripe_customer) }

      it { is_expected.to be false }
    end
  end
end
