require 'rails_helper'

RSpec.describe StripeAccount, type: :model do
  it { is_expected.to respond_to(:charges_enabled) }
  it { is_expected.to respond_to(:country) }
  it { is_expected.to respond_to(:daycare_id) }
  it { is_expected.to respond_to(:details_submitted) }
  it { is_expected.to respond_to(:stripe_id) }

  describe "#is_valid?" do
    subject { stripe_account.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:owner) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { build(:stripe_account, stripe_id: stripe_id, daycare: daycare) }

    context "When daycare is not present" do
      let(:daycare) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }

      it { is_expected.to be false }
    end
  end
end
