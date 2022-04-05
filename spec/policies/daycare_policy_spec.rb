require 'rails_helper'

RSpec.describe DaycarePolicy, type: :policy do
  let(:provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }

  subject { described_class }

  permissions :provider_dashboard? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(User.new(kind: :provider), daycare)
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(provider, daycare)
    end
    it "denies if a guardian tries to view provider dashboard" do
      expect(subject).not_to permit(guardian, daycare)
    end
  end

  permissions :guardian_dashboard? do
    it "denies if guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), daycare)
    end
    it "accepts if guardian does belong to daycare" do
      expect(subject).to permit(guardian, daycare)
    end
    it "denies if a provider tries to view guardian dashboard" do
      expect(subject).not_to permit(provider, daycare)
    end
  end

  permissions :update? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(User.new(kind: :provider), daycare)
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(provider, daycare)
    end
    it "denies if a guardian tries to update daycare" do
      expect(subject).not_to permit(guardian, daycare)
    end
  end


  permissions :edit? do
    it "denies if daycare doesn't belong to provider" do
      expect(subject).not_to permit(User.new(kind: :provider), daycare)
    end
    it "accepts if daycare does belong to provider" do
      expect(subject).to permit(provider, daycare)
    end
    it "denies if a guardian tries to update daycare" do
      expect(subject).not_to permit(guardian, daycare)
    end
  end
end
