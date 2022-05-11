require 'rails_helper'

RSpec.describe BroadcastMessage, type: :model do
  it { is_expected.to respond_to(:message_body) }
  it { is_expected.to respond_to(:recipient_ids) }
  it { is_expected.to respond_to(:users) }
  it { is_expected.to respond_to(:sender_id) }
  it { is_expected.to respond_to(:messages) }

  describe "#is_valid?" do
    subject { broadcast_message.valid? }

    let(:recipient) { create(:user, kind: :guardian, daycare: daycare) }
    let(:recipient_ids) { [recipient&.id] }
    let(:sender) { create(:user, kind: :provider) }
    let(:sender_id) { sender.id }
    let(:daycare) { create(:daycare, owner: sender) }
    let(:message_body) { Faker::Lorem.words }
    let(:broadcast_message) { build(:broadcast_message, recipient_ids: recipient_ids, sender_id: sender_id, message_body: message_body) }

    context "When message_body is not present" do
      let(:message_body) { nil }

      it { is_expected.to be false }
    end

    context "When sender_id not present" do
      let(:sender_id) { nil }

      it { is_expected.to be false }
    end

    context "When recipient_ids not present" do
      let(:recipient_ids) { nil }

      it { is_expected.to be false }
    end
  end

  describe "#save" do
    let(:provider) { create(:user, kind: :provider) }
    let(:recipient) { create(:user, kind: :guardian, daycare: daycare) }
    let(:recipient_two) { create(:user, kind: :guardian, daycare: daycare) }
    let(:daycare) { create(:daycare, owner: sender) }
    let(:sender) { create(:user, kind: :guardian) }
    let(:message_body) { Faker::Lorem.words }
    let(:broadcast_message) { build(:broadcast_message, recipient_ids: [recipient&.id, recipient_two&.id], sender_id: sender.id, message_body: message_body) }

    context "saves with two messages" do
      it "saves creating two messages" do
        expect {
          broadcast_message.save
        }.to change { Message.count }.by(2)
      end
    end

    context "saves creating chat" do
      before { create(:chat, guardian: recipient, provider: provider) }

      it "saves creating missing chat" do
        expect {
          broadcast_message.save
        }.to change { Chat.count }.by(1)
      end
    end
  end
end
