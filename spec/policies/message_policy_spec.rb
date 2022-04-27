require 'rails_helper'

RSpec.describe MessagePolicy, type: :policy do
  let!(:provider) { create(:user, kind: :provider) }
  let!(:alt_provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:alt_daycare) { create(:daycare, user_id: alt_provider.id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:alt_guardian) { create(:user, kind: :guardian, daycare: alt_daycare) }
  let(:chat) { create(:chat, provider: provider, guardian: guardian) }
  let(:alt_chat) { create(:chat, provider: alt_provider, guardian: alt_guardian) }
  let!(:message_from_guardian) { build(:message, chat: chat, user: guardian, recipient: provider) }
  let!(:message_from_provider) { build(:message, chat: chat, user: provider, recipient: guardian) }
  let!(:message_from_alt_guardian) { build(:message, chat: alt_chat, user: alt_guardian, recipient: provider) }
  let!(:message_from_alt_provider) { build(:message, chat: alt_chat, user: alt_provider, recipient: guardian) }

  subject { described_class }
  
  permissions ".scope" do
    it "only shows providers daycares entered forms" do
      expect(MessagePolicy::Scope.new(provider, Message).resolve).to eq  Message.where(chat_id: provider.as_provider_chats.pluck(:id))
    end
    it "only shows guardians entered forms" do
      expect(MessagePolicy::Scope.new(guardian, Message).resolve).to eq guardian.as_guardian_chat.messages
    end
  end

  permissions :create? do
    it "denies if message recipient doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(alt_provider, message_from_provider)
    end
    it "accepts if message does belong to providers owned daycare" do
      expect(subject).to permit(provider, message_from_provider)
    end
    it "denies if message's guardian/user doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, message_from_guardian)
    end
    it "accepts if message's guardian does belong to daycare" do
      expect(subject).to permit(guardian, message_from_guardian)
    end
  end

  permissions :new? do
    let(:alt_daycare) { nil }

    it "denies if message doesn't belong to user" do
      expect(subject).not_to permit(alt_provider, message_from_provider)
    end
    it "accepts if message does belong user" do
      expect(subject).to permit(provider, message_from_provider)
    end
  end

  permissions :update? do
    it "denies if message doesn't belong to user" do
      expect(subject).not_to permit(alt_provider, message_from_provider)
    end
    it "accepts if message does belong user" do
      expect(subject).to permit(provider, message_from_provider)
    end
  end

  permissions :edit? do
    it "denies if message doesn't belong to user" do
      expect(subject).not_to permit(alt_provider, message_from_provider)
    end
    it "accepts if message does belong user" do
      expect(subject).to permit(provider, message_from_provider)
    end
  end


  permissions :show? do
    it "denies if message doesn't belong to user or recipient as" do
      expect(subject).not_to permit(alt_provider, message_from_guardian)
    end
    it "accepts if message does belong to user or recipient" do
      expect(subject).to permit(provider, message_from_guardian)
    end
  end
end
