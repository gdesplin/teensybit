require 'rails_helper'

RSpec.describe StripeCustomer, type: :model do
  it { is_expected.to respond_to(:balance) }
  it { is_expected.to respond_to(:delinquent) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:phone) }
  it { is_expected.to respond_to(:stripe_id) }

  describe "#is_valid?" do
    subject { stripe_customer.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:stripe_customer) { build(:stripe_customer, stripe_id: stripe_id) }

    context "When stripe_id not unique" do
      before { create(:stripe_customer, stripe_id: stripe_id) }

      it { is_expected.to be false }
    end
  end
end
