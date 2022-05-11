require 'rails_helper'

RSpec.describe Chat, type: :model do
  it { is_expected.to respond_to(:guardian_id) }
  it { is_expected.to respond_to(:provider_id) }

  describe "#is_valid?" do
    subject { chat.valid? }

    let(:guardian) { build(:user) }
    let(:provider) { build(:user) }
    let(:chat) { build(:chat, guardian: guardian, provider: provider) }

    context "When guardian is not present" do
      let(:guardian) { nil }

      it { is_expected.to be false }
    end

    context "When provider not present" do
      let(:provider) { nil }

      it { is_expected.to be false }
    end
  end
end
