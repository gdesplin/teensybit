require 'rails_helper'

RSpec.describe Form, type: :model do
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:daycare_id) }
  it { is_expected.to respond_to(:title) }

  describe "#is_valid?" do
    subject { form.valid? }

    let(:form) { build(:form, title: title, daycare: daycare) }
    let(:owner) { create(:user) }
    let(:other_owner) { create(:user) }
    let(:daycare) { create(:daycare, owner: owner) }
    let(:other_daycare) { create(:daycare, owner: other_owner) }
    let(:title) { Faker::Lorem.unique.words }

    context "When daycare_id is not present" do
      let(:daycare) { nil }

      it { is_expected.to be false }
    end

    context "When title not present" do
      let(:title) { nil }

      it { is_expected.to be false }
    end

    context "When title is present in another daycare" do
      before { create(:form, title: title, daycare: other_daycare) }

      it { is_expected.to be true }
    end

    context "When title is present in same daycare" do
      before { create(:form, title: title, daycare: daycare) }

      it { is_expected.to be false }
    end
  end
end
