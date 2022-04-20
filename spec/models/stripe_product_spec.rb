require 'rails_helper'

RSpec.describe StripeProduct, type: :model do
  it { is_expected.to respond_to(:active) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:stripe_account_id) }
  it { is_expected.to respond_to(:stripe_id) }

  describe "#is_valid?" do
    subject { stripe_product.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:owner) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }
    let(:stripe_product) { build(:stripe_product, stripe_account: stripe_account, stripe_id: stripe_id) }

    context "When stripe_account is not present" do
      let(:stripe_account) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_product, stripe_account: stripe_account, stripe_id: stripe_id) }

      it { is_expected.to be false }
    end
  end
end
