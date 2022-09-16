require 'rails_helper'

RSpec.describe Child, type: :model do
  it { is_expected.to respond_to(:daycare_id) }
  it { is_expected.to respond_to(:name) }

  describe "#is_valid?" do
    subject { child.valid? }

    let(:child) { build(:child, daycare: daycare) }
    let(:daycare) { build(:daycare) }
    let(:name) { Faker::Name.name }

    context "When daycare is not present" do
      let(:daycare) { nil }

      it { is_expected.to be false }
    end

    context "When name not present" do
      let(:name) { nil }

      it { is_expected.to be false }
    end
  end
end
