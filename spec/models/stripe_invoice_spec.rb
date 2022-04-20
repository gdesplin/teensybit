require 'rails_helper'

RSpec.describe StripeInvoice, type: :model do
  it { is_expected.to respond_to(:collection_method) }
  it { is_expected.to respond_to(:hosted_invoice_url) }
  it { is_expected.to respond_to(:invoice_pdf) }
  it { is_expected.to respond_to(:paid) }
  it { is_expected.to respond_to(:stripe_customer_id) }
  it { is_expected.to respond_to(:stripe_id) }
  it { is_expected.to respond_to(:stripe_subscription_id) }
  it { is_expected.to respond_to(:total_cents) }
  it { is_expected.to respond_to(:total_currency) }

  describe "#is_valid?" do
    subject { stripe_invoice.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:owner) { create(:user) }
    let(:user) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }
    let(:stripe_customer) { create(:stripe_customer) }
    let(:stripe_price) { create(:stripe_price, stripe_product: stripe_product, user: user) }
    let(:stripe_product) { create(:stripe_product, stripe_account: stripe_account) }
    let(:stripe_invoice) { build(:stripe_invoice, stripe_id: stripe_id, stripe_customer: stripe_customer) }

    context "When stripe_customer is not present" do
      let(:stripe_customer) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id is not present" do
      let(:stripe_id) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_invoice, stripe_id: stripe_id, stripe_customer: stripe_customer) }

      it { is_expected.to be false }
    end
  end
end
