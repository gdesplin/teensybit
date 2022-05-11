require 'rails_helper'

RSpec.describe ChildEventPolicy, type: :policy do
  let!(:provider) { create(:user, kind: :provider) }
  let!(:provider_2) { create(:user, kind: :provider) }
  let!(:provider_3) { create(:user, kind: :provider) }
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let!(:daycare_2) { create(:daycare, user_id: provider_2.id) }
  let!(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let!(:guardian_2) { create(:user, kind: :guardian, daycare: daycare) }
  let!(:guardian_3) { create(:user, kind: :guardian, daycare: daycare_2) }
  let!(:child) { create(:child, users: [guardian], daycare: daycare)}
  let!(:child_2) { create(:child, users: [guardian_2], daycare: daycare)}
  let!(:child_3) { create(:child, users: [guardian_3], daycare: daycare_2)}
  let!(:child_event) { create(:child_event, user: guardian, child: child)}
  let!(:child_event_2) { create(:child_event, user: guardian_2, child: child_2)}
  let!(:child_event_3) { create(:child_event, user: guardian_3, child: child_3)}

  subject { described_class }

  permissions ".scope" do
    it "only shows child_events providers owned daycare has" do
      expect(ChildEventPolicy::Scope.new(provider, ChildEvent).resolve).to eq provider.owned_daycare.child_events.order(updated_at: :desc)
    end
    it "only shows child_events guardians children are in" do
      expect(ChildEventPolicy::Scope.new(guardian, ChildEvent).resolve).to eq guardian.daycare.child_events.where(child_id: guardian.children.pluck(:id)).order(updated_at: :desc)
    end
  end

  permissions :show? do
    it "denies if child_event doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, child_event_3)
    end
    it "accepts if child_event does belong to providers owned daycare" do
      expect(subject).to permit(provider, child_event)
    end
    it "denies if child_event's guardian doesn't have child" do
      expect(subject).not_to permit(guardian, child_event_2)
    end
    it "accepts if child_event's guardian does have child" do
      expect(subject).to permit(guardian, child_event)
    end
  end

  permissions :create? do
    it "denies if child_event doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, child_event_3)
    end
    it "accepts if child_event does belong to providers owned daycare" do
      expect(subject).to permit(provider, child_event)
    end
    it "denies if child_event's guardian doesn't have child" do
      expect(subject).not_to permit(guardian, child_event_2)
    end
    it "accepts if child_event's guardian does have child" do
      expect(subject).to permit(guardian, child_event)
    end
  end

  permissions :new? do
    it "denies if provider doesn't have an owned daycare" do
      expect(subject).not_to permit(provider_3, ChildEvent.new)
    end
    it "accepts if provider does have an owned daycare" do
      expect(subject).to permit(provider, ChildEvent.new)
    end
    it "accepts if guardian does does belong to daycare" do
      expect(subject).to permit(guardian, ChildEvent.new)
    end
  end

  permissions :update? do
    it "denies if child_event doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, child_event_3)
    end
    it "accepts if child_event does belong to providers owned daycare" do
      expect(subject).to permit(provider, child_event)
    end
    it "denies if child_event doesn't belong to guardian" do
      expect(subject).not_to permit(guardian, child_event_2)
    end
    it "accepts if child_event does belong to guardian" do
      expect(subject).to permit(guardian, child_event)
    end
  end

  permissions :edit? do
    it "denies if child_event doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, child_event_3)
    end
    it "accepts if child_event does belong to providers owned daycare" do
      expect(subject).to permit(provider, child_event)
    end
    it "denies if child_event doesn't belong to guardian" do
      expect(subject).not_to permit(guardian, child_event_2)
    end
    it "accepts if child_event does belong to guardian" do
      expect(subject).to permit(guardian, child_event)
    end
  end

  permissions :destroy? do
    it "denies if child_event doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(provider, child_event_3)
    end
    it "accepts if child_event does belong to providers owned daycare" do
      expect(subject).to permit(provider, child_event)
    end
    it "denies if child_event doesn't belong to guardian" do
      expect(subject).not_to permit(guardian, child_event_2)
    end
    it "accepts if child_event does belong to guardian" do
      expect(subject).to permit(guardian, child_event)
    end
  end
end
