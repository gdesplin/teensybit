require 'rails_helper'

RSpec.describe StripePrice, type: :model do
  it { is_expected.to respond_to(:active) }
  it { is_expected.to respond_to(:amount_cents) }
  it { is_expected.to respond_to(:amount_currency) }
  it { is_expected.to respond_to(:nickname) }
  it { is_expected.to respond_to(:recurring) }
  it { is_expected.to respond_to(:stripe_id) }
  it { is_expected.to respond_to(:stripe_product_id) }
  it { is_expected.to respond_to(:user_id) }

  describe "#is_valid?" do
    subject { stripe_price.valid? }

    let(:stripe_id) { "bpc_1JfnoiDFrj4JR6YJ0b8Ke5I9" }
    let(:nickname) { Faker::Lorem.word }
    let(:amount) { Faker::Number.positive }
    let(:recurring) { { "interval" => "week", "interval_count" => 1 } }
    let(:owner) { create(:user) }
    let(:user) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:stripe_account) { create(:stripe_account, stripe_id: stripe_id, daycare: daycare) }
    let(:stripe_product) { create(:stripe_product, stripe_account: stripe_account) }
    let(:stripe_price) do
       build(:stripe_price,
        stripe_id: stripe_id,
        stripe_product: stripe_product,
        user: user,
        nickname: nickname,
        recurring: recurring,
        amount: amount
      )
    end

    context "When stripe_product is not present" do
      let(:stripe_product) { nil }

      it { is_expected.to be false }
    end

    context "When user is not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end

    context "When nickname is not present" do
      let(:nickname) { nil }

      it { is_expected.to be false }
    end

    context "When amount is not present" do
      let(:amount) { nil }

      it { is_expected.to be false }
    end

    context "When amount is negative" do
      let(:amount) { Faker::Number.negative }

      it { is_expected.to be false }
    end

    context "When recurring is not present" do
      let(:recurring) { nil }

      it { is_expected.to be false }
    end

    context "When recurring is not json" do
      let(:recurring) { "not json" }

      it { is_expected.to be false }
    end

    context "When recurring is missing a required json key" do
      let(:recurring) { {"interval_count" => 1 } }

      it { is_expected.to be false }
    end

    context "When recurring is mispelling a required json key" do
      let(:recurring) {  { "intervals" => "week", "interval_count" => 1 } }

      it { is_expected.to be false }
    end

    context "When recurring is using incorrect json integer value" do
      let(:recurring) {  { "intervals" => "week", "interval_count" => "1" } }

      it { is_expected.to be false }
    end

    context "When recurring is using incorrect json string value" do
      let(:recurring) {  { "intervals" => 2, "interval_count" => 1 } }

      it { is_expected.to be false }
    end

    context "When stripe_id not unique" do
      before { create(:stripe_price, stripe_id: stripe_id, stripe_product: stripe_product, user: user) }

      it { is_expected.to be false }
    end
  end
end
