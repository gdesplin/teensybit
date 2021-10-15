require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  let(:provider) { create(:user, kind: :provider) }
  let(:daycare) { create(:daycare, user_id: provider.id) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }

  subject { described_class }

  permissions :destroy? do
    it "denies if guardian/user doesn't belong to providers daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), guardian)
    end
    it "accepts if guardian/user does belong to providers daycare" do
      daycare.touch
      expect(subject).to permit(provider, guardian)
    end
  end

  permissions :show? do
    it "denies if guardian/user doesn't belong to providers daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), guardian)
    end
    it "accepts if guardian/user does belong to providers daycare" do
      daycare.touch
      expect(subject).to permit(provider, guardian)
    end
  end
end
