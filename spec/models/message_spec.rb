require 'rails_helper'

RSpec.describe Message, type: :model do
  it { is_expected.to respond_to(:user_id) }
  it { is_expected.to respond_to(:recipient_id) }
  it { is_expected.to respond_to(:chat_id) }
  it { is_expected.to respond_to(:message_body) }

  describe "#is_valid?" do
    subject { message.valid? }

    let(:user) { create(:user) }
    let(:recipient) { create(:user) }
    let(:guardian) { create(:user) }
    let(:provider) { create(:user) }
    let(:chat) { create(:chat, guardian: guardian, provider: provider) }
    let(:message) { build(:message, user: user, recipient: recipient, chat: chat, message_body: message_body) }
    let(:message_body) { Faker::Lorem.unique.words }

    context "When user is not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end

    context "When recipient not present" do
      let(:recipient) { nil }

      it { is_expected.to be false }
    end

    context "When user not present" do
      let(:user) { nil }

      it { is_expected.to be false }
    end

    context "When chat not present" do
      let(:chat) { nil }

      it { is_expected.to be false }
    end

    context "When message_body not present" do
      let(:message_body) { nil }

      it { is_expected.to be false }
    end
  end
end
