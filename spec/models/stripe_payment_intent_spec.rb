require 'rails_helper'

RSpec.describe StripePaymentIntent, type: :model do
  it { is_expected.to respond_to(:amount_received_cents) }
  it { is_expected.to respond_to(:amount_received_currency) }
  it { is_expected.to respond_to(:stripe_customer_id) }
  it { is_expected.to respond_to(:stripe_id) }
  it { is_expected.to respond_to(:stripe_invoice_id) }

  describe "#is_valid?" do
    subject { stripe_payment_intent.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:owner) { create(:user) }
    let(:user) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { create(:stripe_account, daycare: daycare) }
    let(:stripe_customer) { create(:stripe_customer) }
    let(:stripe_customer_id) { stripe_customer.id }
    let(:stripe_price) { create(:stripe_price, stripe_product: stripe_product, user: user) }
    let(:stripe_product) { create(:stripe_product, stripe_account: stripe_account) }
    let(:stripe_invoice) { create(:stripe_invoice, stripe_customer: stripe_customer) }
    let(:stripe_payment_intent) { build(:stripe_payment_intent, stripe_id: stripe_id, stripe_customer_id: stripe_customer_id, stripe_invoice: stripe_invoice) }

    context "When stripe_customer is not present" do
      before { stripe_customer }

      let(:stripe_customer_id) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id is not present" do
      before { stripe_customer }

      let(:stripe_id) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_payment_intent, stripe_id: stripe_id, stripe_customer: stripe_customer) }

      it { is_expected.to be false }
    end
  end
end
