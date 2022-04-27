require 'rails_helper'

RSpec.describe ChatPolicy, type: :policy do
  let(:provider) { create(:user, kind: :provider) }
  let(:alt_provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, owner: provider) }
  let(:alt_daycare) { create(:daycare, owner: alt_provider) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:alt_guardian) { create(:user, kind: :guardian, daycare: alt_daycare) }
  let(:other_guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:chat) { build(:chat, provider: provider, guardian: guardian) }

  subject { described_class }

  permissions ".scope" do
    it "only shows chat providers owned daycare has" do
      expect(ChatPolicy::Scope.new(provider, Chat).resolve).to eq provider.as_provider_chats
    end
    it "only shows chat guardians children are in" do
      expect(ChatPolicy::Scope.new(guardian, Chat).resolve).to eq guardian.as_guardian_chat
    end
  end

  permissions :create? do
    it "denies if chat doesn't either guardian or provider" do
      expect(subject).not_to permit(alt_provider, chat)
    end
    it "accepts if chat does belong to providers owned daycare" do
      expect(subject).to permit(provider, chat)
    end
    it "denies if chat's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, chat)
    end
    it "denies if chat's guardian does belong to daycare, but isn't involved in chat" do
      expect(subject).not_to permit(other_guardian, chat)
    end
    it "accepts if chat's guardian does belong to daycare" do
      expect(subject).to permit(guardian, chat)
    end
  end

  permissions :show? do
    it "denies if chat doesn't either guardian or provider" do
      expect(subject).not_to permit(alt_provider, chat)
    end
    it "accepts if chat does belong to providers owned daycare" do
      expect(subject).to permit(provider, chat)
    end
    it "denies if chat's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(alt_guardian, chat)
    end
    it "denies if chat's guardian does belong to daycare, but isn't involved in chat" do
      expect(subject).not_to permit(other_guardian, chat)
    end
    it "accepts if chat's guardian does belong to daycare" do
      expect(subject).to permit(guardian, chat)
    end
  end
end
