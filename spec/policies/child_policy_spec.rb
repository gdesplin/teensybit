require 'rails_helper'

RSpec.describe ChildPolicy, type: :policy do
  let!(:daycare) { create(:daycare, user_id: provider.id) }
  let(:provider) { create(:user, kind: :provider) }
  let(:guardian) { create(:user, kind: :guardian, daycare: daycare) }
  let(:child) { create(:child, users: [guardian], daycare: daycare)}

  subject { described_class }

  permissions ".scope" do
    it "only shows children providers owned daycare has" do
      expect(ChildPolicy::Scope.new(provider, ChildEvent).resolve).to eq provider.owned_daycare&.children.order(name: :asc)
    end
    it "only shows children guardians children are in" do
      expect(ChildPolicy::Scope.new(guardian, ChildEvent).resolve).to eq guardian.children.order(name: :asc)
    end
  end

  permissions :create? do
    it "denies if child doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), Child.new(daycare: daycare))
    end
    it "accepts if child does belong to providers owned daycare" do
      expect(subject).to permit(provider, Child.new(daycare: daycare))
    end
    it "denies if child's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), Child.new)
    end
    it "accepts if child's guardian does belong to daycare" do
      expect(subject).to permit(guardian, Child.new(users: [guardian], daycare: daycare))
    end
  end

  permissions :new? do
    it "denies if child doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), Child.new(daycare: daycare))
    end
    it "accepts if child does belong to providers owned daycare" do
      expect(subject).to permit(provider, Child.new(daycare: daycare))
    end
    it "denies if child's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), Child.new)
    end
    it "accepts if child's guardian does belong to daycare" do
      expect(subject).to permit(guardian, Child.new(users: [guardian], daycare: daycare))
    end
  end

  permissions :update? do
    it "denies if child doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), Child.new(daycare: daycare))
    end
    it "accepts if child does belong to providers owned daycare" do
      expect(subject).to permit(provider, child)
    end
    it "denies if child's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), Child.new)
    end
    it "accepts if child's guardian does belong to daycare" do
      expect(subject).to permit(guardian, child)
    end
  end

  permissions :edit? do
    it "denies if child doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), Child.new(daycare: daycare))
    end
    it "accepts if child does belong to providers owned daycare" do
      expect(subject).to permit(provider, child)
    end
    it "denies if child's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), Child.new)
    end
    it "accepts if child's guardian does belong to daycare" do
      expect(subject).to permit(guardian, child)
    end
  end


  permissions :show? do
    it "denies if child doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), Child.new(daycare: daycare))
    end
    it "accepts if child does belong to providers owned daycare" do
      expect(subject).to permit(provider, child)
    end
    it "denies if child's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), Child.new)
    end
    it "accepts if child's guardian does belong to daycare" do
      expect(subject).to permit(guardian, child)
    end
  end

  permissions :destroy? do
    it "denies if child doesn't belong to providers owned daycare" do
      expect(subject).not_to permit(User.new(kind: :provider), Child.new(daycare: daycare))
    end
    it "accepts if child does belong to providers owned daycare" do
      expect(subject).to permit(provider, child)
    end
    it "denies if child's guardian doesn't belong to daycare" do
      expect(subject).not_to permit(User.new(kind: :guardian), Child.new)
    end
    it "accepts if child's guardian does belong to daycare" do
      expect(subject).to permit(guardian, child)
    end
  end
end
