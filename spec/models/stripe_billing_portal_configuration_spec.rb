require 'rails_helper'

RSpec.describe StripeBillingPortalConfiguration, type: :model do
  it { is_expected.to respond_to(:business_profile) }
  it { is_expected.to respond_to(:features) }
  it { is_expected.to respond_to(:stripe_account_id) }
  it { is_expected.to respond_to(:stripe_id) }

  describe "#is_valid?" do
    subject { stripe_billing_portal_configuration.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:owner) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }
    let(:stripe_billing_portal_configuration) { build(:stripe_billing_portal_configuration, stripe_id: stripe_id) }

    context "When stripe_id is not present" do
      let(:stripe_id) { nil }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_billing_portal_configuration, stripe_account: stripe_account) }

      it { is_expected.to be false }
    end
  end
end
