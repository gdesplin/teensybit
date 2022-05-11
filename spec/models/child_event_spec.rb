require 'rails_helper'

RSpec.describe ChildEvent, type: :model do
  it { is_expected.to respond_to(:child_id) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:happened_at) }
  it { is_expected.to respond_to(:user_id) }

  describe "#is_valid?" do
    subject { child_event.valid? }

    let(:child) { build(:child) }
    let(:child_event) { build(:child_event, child: child, user: user, happened_at: happened_at) }
    let(:happened_at) { Time.now }
    let(:user) { build(:user) }

    context "When user is not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end

    context "When child not present" do
      let(:child) { nil }

      it { is_expected.to be false }
    end

    context "When happened_at not present" do
      let(:happened_at) { nil }

      it { is_expected.to be false }
    end
  end
end
